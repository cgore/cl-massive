;;;; Copyright (c) 2026, Christopher Mark Gore,
;;;; Soli Deo Gloria,
;;;; All rights reserved.
;;;;
;;;; 22 Forest Glade Court, Saint Charles, Missouri 63304 USA.
;;;; Web: http://cgore.com
;;;; Email: cgore@cgore.com
;;;;
;;;; Redistribution and use in source and binary forms, with or without
;;;; modification, are permitted provided that the following conditions are met:
;;;;
;;;;     * Redistributions of source code must retain the above copyright
;;;;       notice, this list of conditions and the following disclaimer.
;;;;
;;;;     * Redistributions in binary form must reproduce the above copyright
;;;;       notice, this list of conditions and the following disclaimer in the
;;;;       documentation and/or other materials provided with the distribution.
;;;;
;;;;     * Neither the name of Christopher Mark Gore nor the names of other
;;;;       contributors may be used to endorse or promote products derived from
;;;;       this software without specific prior written permission.
;;;;
;;;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;;;; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;;;; IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;;;; ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;;;; LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;;;; CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;;;; SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;;;; INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;;;; CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;;;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;;;; POSSIBILITY OF SUCH DAMAGE.

(defpackage #:massive/flat-files
  (:use #:common-lisp #:sigma/behave #:massive/rest-api)
  (:export
   #:*s3-timeout-seconds*
   #:flat-dataset
   #:flat-dataset-p
   #:flat-dataset-name
   #:flat-dataset-asset
   #:flat-dataset-kind
   #:flat-dataset-prefix
   #:flat-dataset-exchange
   #:flat-datasets
   #:futures-dataset
   #:flat-object-key
   #:dataset-skip-weekends-p
   #:date-range
   #:list-flat-files
   #:download-flat-object
   #:download-flat-file
   #:map-csv-stream
   #:map-gzip-csv
   #:map-flat-file
   #:read-flat-file
   #:parse-csv-line
   #:parse-list-bucket))
(in-package #:massive/flat-files)

(defvar *s3-timeout-seconds* 300
  "Read timeout for a flat-file download.  A day of trades is a large object.")

(defparameter *empty-sha256*
  "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  "SHA-256 of the empty payload.  GET requests sign this.")

(defstruct (flat-dataset (:predicate flat-dataset-p))
  name asset kind prefix exchange)

(defvar *flat-datasets* (make-hash-table :test #'eq)
  "Keyword name to FLAT-DATASET.  The prefix is the S3 key up to the year.")

(defun register-dataset (name asset kind prefix &optional exchange)
  (setf (gethash name *flat-datasets*)
        (make-flat-dataset :name name
                           :asset asset
                           :kind kind
                           :prefix prefix
                           :exchange exchange)))

(dolist (spec '((:stocks-day :stocks :day "us_stocks_sip/day_aggs_v1")
                (:stocks-minute :stocks :minute "us_stocks_sip/minute_aggs_v1")
                (:stocks-trades :stocks :trades "us_stocks_sip/trades_v1")
                (:stocks-quotes :stocks :quotes "us_stocks_sip/quotes_v1")
                (:options-day :options :day "us_options_opra/day_aggs_v1")
                (:options-minute :options :minute "us_options_opra/minute_aggs_v1")
                (:options-trades :options :trades "us_options_opra/trades_v1")
                (:options-quotes :options :quotes "us_options_opra/quotes_v1")
                (:indices-day :indices :day "us_indices/day_aggs_v1")
                (:indices-minute :indices :minute "us_indices/minute_aggs_v1")
                (:indices-values :indices :values "us_indices/values_v1")
                (:forex-day :forex :day "global_forex/day_aggs_v1")
                (:forex-minute :forex :minute "global_forex/minute_aggs_v1")
                (:forex-quotes :forex :quotes "global_forex/quotes_v1")
                (:crypto-day :crypto :day "global_crypto/day_aggs_v1")
                (:crypto-minute :crypto :minute "global_crypto/minute_aggs_v1")
                (:crypto-trades :crypto :trades "global_crypto/trades_v1")))
  (apply #'register-dataset spec))

(dolist (exchange '(:cme :cbot :nymex :comex))
  (dolist (pair '((:minute "minute_aggs_v1")
                  (:session "session_aggs_v1")
                  (:trades "trades_v1")
                  (:quotes "quotes_v1")))
    (register-dataset
     (intern (format nil "FUTURES-~A-~A"
                     (symbol-name exchange)
                     (symbol-name (first pair)))
             :keyword)
     :futures
     (first pair)
     (format nil "us_futures_~(~A~)/~A" exchange (second pair))
     exchange)))

(defun flat-datasets ()
  "Every known dataset, sorted by prefix."
  (let ((all '()))
    (maphash (lambda (name dataset)
               (declare (ignore name))
               (push dataset all))
             *flat-datasets*)
    (sort all #'string< :key #'flat-dataset-prefix)))

(defun flat-dataset (name)
  "Dataset for a keyword name, a prefix string, or a FLAT-DATASET."
  (cond ((flat-dataset-p name) name)
        ((keywordp name)
         (or (gethash name *flat-datasets*)
             (error "Unknown flat-file dataset ~S." name)))
        ((stringp name)
         (or (loop for dataset in (flat-datasets)
                   when (string= name (flat-dataset-prefix dataset))
                     return dataset)
             (error "Unknown flat-file prefix ~S." name)))
        (t (error "Unknown flat-file dataset ~S." name))))

(defun futures-dataset (exchange kind)
  "KIND is :MINUTE, :SESSION, :TRADES, or :QUOTES.
EXCHANGE is :CME, :CBOT, :NYMEX, or :COMEX."
  (let ((name (intern (format nil "FUTURES-~A-~A"
                              (string-upcase (string exchange))
                              (string-upcase (string kind)))
                      :keyword)))
    (or (gethash name *flat-datasets*)
        (error "Unknown futures dataset ~A ~A." exchange kind))))

(defun flat-object-key (dataset date)
  "S3 key for one trading day's file, without the bucket.
DATE is YYYY-MM-DD, a (year month day) list, or a universal/UNIX time."
  (let ((ymd (canonicalize-date date))
        (prefix (flat-dataset-prefix (flat-dataset dataset))))
    (unless (and (stringp ymd) (= (length ymd) 10))
      (error "Flat-file date must be YYYY-MM-DD. Got ~S." date))
    (format nil "~A/~A/~A/~A.csv.gz"
            prefix (subseq ymd 0 4) (subseq ymd 5 7) ymd)))

(defun weekday-p (universal)
  "Monday through Friday in UTC.  Common Lisp's day-of-week is 0 for Monday."
  (multiple-value-bind (second minute hour day month year dow)
      (decode-universal-time universal 0)
    (declare (ignore second minute hour day month year))
    (<= dow 4)))

(defun ymd-noon (ymd)
  (encode-universal-time 0 0 12
                         (parse-integer ymd :start 8 :end 10)
                         (parse-integer ymd :start 5 :end 7)
                         (parse-integer ymd :start 0 :end 4)
                         0))

(defun date-range (from to &key skip-weekends)
  "Inclusive list of YYYY-MM-DD strings from FROM through TO.
SKIP-WEEKENDS drops Saturday and Sunday."
  (let* ((start-ymd (canonicalize-date from))
         (end-ymd (canonicalize-date to))
         (start (ymd-noon start-ymd))
         (end (ymd-noon end-ymd)))
    (when (> start end)
      (error "Flat-file FROM ~A is after TO ~A." start-ymd end-ymd))
    (loop for ut = start then (+ ut 86400)
          while (<= ut end)
          when (or (not skip-weekends) (weekday-p ut))
            collect (multiple-value-bind (second minute hour day month year)
                        (decode-universal-time ut 0)
                      (declare (ignore second minute hour))
                      (format nil "~4,'0D-~2,'0D-~2,'0D" year month day)))))

(defun dataset-skip-weekends-p (dataset)
  "Stocks, options, indices, and futures files are not published on weekends.
Crypto and forex files can be."
  (member (flat-dataset-asset (flat-dataset dataset))
          '(:stocks :options :indices :futures)))

(behavior 'flat-object-key
  (should-string= "us_stocks_sip/day_aggs_v1/2024/03/2024-03-01.csv.gz"
                  (flat-object-key :stocks-day "2024-03-01"))
  (should-string= "us_indices/values_v1/2024/01/2024-01-02.csv.gz"
                  (flat-object-key :indices-values '(2024 1 2)))
  (should-string= "us_futures_cme/minute_aggs_v1/2024/03/2024-03-01.csv.gz"
                  (flat-object-key (futures-dataset :cme :minute) "2024-03-01"))
  (should-string= "global_crypto/day_aggs_v1/2024/03/2024-03-01.csv.gz"
                  (flat-object-key "global_crypto/day_aggs_v1" "2024-03-01")))

(behavior 'date-range
  (should-equal '("2024-03-01" "2024-03-02" "2024-03-03" "2024-03-04")
                (date-range "2024-03-01" "2024-03-04"))
  (should-equal '("2024-03-01" "2024-03-04")
                (date-range "2024-03-01" "2024-03-04" :skip-weekends t))
  (should-be-true (dataset-skip-weekends-p :stocks-day))
  (should-be-false (dataset-skip-weekends-p :crypto-day)))

(behavior 'flat-datasets
  (should-be-true (>= (length (flat-datasets)) 31))
  (should-eq :stocks (flat-dataset-asset (flat-dataset :stocks-trades)))
  (should-eq :cme (flat-dataset-exchange (futures-dataset :cme :quotes))))

;;;; -- CSV -------------------------------------------------------------------

(defun parse-csv-line (line)
  "One CSV record as a list of strings.  Quotes and doubled quotes are honored.
Massive condition columns look like \"12,37\"."
  (let ((fields '())
        (field (make-string-output-stream))
        (quoted nil)
        (index 0))
    (loop while (< index (length line))
          for char = (char line index)
          do (cond ((and quoted
                         (char= char #\")
                         (< (1+ index) (length line))
                         (char= (char line (1+ index)) #\"))
                    (write-char #\" field)
                    (incf index 2))
                   ((char= char #\")
                    (setf quoted (not quoted))
                    (incf index))
                   ((and (char= char #\,) (not quoted))
                    (push (get-output-stream-string field) fields)
                    (setf field (make-string-output-stream))
                    (incf index))
                   (t
                    (write-char char field)
                    (incf index))))
    (push (get-output-stream-string field) fields)
    (nreverse fields)))

(defun header-keyword (name)
  (let ((trimmed (string-trim '(#\Space #\Tab #\Return #\") name)))
    (intern (string-upcase (substitute #\- #\_ trimmed)) :keyword)))

(defun numeric-token-p (string)
  (and (plusp (length string))
       (every (lambda (char)
                (or (digit-char-p char)
                    (member char '(#\. #\- #\+ #\e #\E))))
              string)
       (find-if #'digit-char-p string)))

(defun parse-field (string)
  (let ((text (string-trim '(#\Space #\Tab #\Return) string)))
    (cond ((zerop (length text)) nil)
          ((numeric-token-p text)
           (let ((*read-eval* nil))
             (handler-case
                 (multiple-value-bind (value end) (read-from-string text)
                   (if (and (numberp value) (= end (length text)))
                       value
                       text))
               (error () text))))
          (t text))))

(defun map-csv-stream (stream function &key ticker)
  "Call FUNCTION with a plist for each data row of the CSV on STREAM.
TICKER, when given, keeps that symbol only.  Returns the number of rows
passed to FUNCTION.  The header is not a row."
  (let* ((header-line (read-line stream nil nil))
         (headers (and header-line
                       (mapcar #'header-keyword
                               (parse-csv-line
                                (string-right-trim '(#\Return) header-line)))))
         (wanted (and ticker (canonicalize-ticker ticker)))
         (count 0))
    (unless headers
      (return-from map-csv-stream 0))
    (loop for line = (read-line stream nil nil)
          while line
          for trimmed = (string-right-trim '(#\Return) line)
          unless (zerop (length trimmed))
            do (let* ((fields (mapcar #'parse-field (parse-csv-line trimmed)))
                      (row (loop for key in headers
                                 for value in fields
                                 nconc (list key value))))
                 (when (or (null wanted)
                           (string= wanted (getf row :ticker)))
                   (funcall function row)
                   (incf count))))
    count))

(defun map-gzip-csv (pathname function &key ticker)
  "MAP-CSV-STREAM over a gzip file."
  (with-open-file (raw pathname :element-type '(unsigned-byte 8))
    (let ((text (flexi-streams:make-flexi-stream
                 (chipz:make-decompressing-stream 'chipz:gzip raw)
                 :external-format :utf-8)))
      (map-csv-stream text function :ticker ticker))))

(behavior 'parse-csv-line
  (should-equal '("MSFT" "12,37" "" "11")
                (parse-csv-line "MSFT,\"12,37\",,11"))
  (should-equal '("A" "say \"hi\"" "1")
                (parse-csv-line "A,\"say \"\"hi\"\"\",1")))

(behavior 'map-csv-stream
  (let ((rows '()))
    (with-input-from-string
        (in (format nil "ticker,volume,open,close,high,low,window_start,transactions~@
AAPL,100,10,11,12,9,1700000000000000000,3~@
MSFT,\"12,37\",20,21,22,19,1700000000000000000,2~%"))
      (should= 1 (map-csv-stream in (lambda (row) (push row rows)) :ticker "aapl")))
    (let ((row (first rows)))
      (should-string= "AAPL" (getf row :ticker))
      (should= 100 (getf row :volume))
      (should= 11 (getf row :close))
      (should= 1700000000000000000 (getf row :window-start)))))

(behavior 'map-gzip-csv
  (let* ((path (asdf:system-relative-pathname
                :massive "test-fixtures/aapl-day.csv.gz"))
         (rows '()))
    (should= 1 (map-gzip-csv path (lambda (row) (push row rows)) :ticker "AAPL"))
    (should-string= "AAPL" (getf (first rows) :ticker))
    (should= 11 (getf (first rows) :close))
    (should= 2 (map-gzip-csv path (lambda (row) (declare (ignore row))) ))))

;;;; -- S3 --------------------------------------------------------------------

(defun aws-encode (string)
  "AWS URI encoding.  Unreserved characters stay.  Everything else is %HH."
  (let ((octets (babel:string-to-octets string :encoding :utf-8)))
    (with-output-to-string (out)
      (loop for byte across octets
            for char = (code-char byte)
            do (if (and (< byte 128)
                        (or (digit-char-p char)
                            (char<= #\A char #\Z)
                            (char<= #\a char #\z)
                            (member char '(#\- #\_ #\. #\~))))
                   (write-char char out)
                   (format out "%~2,'0X" byte))))))

(defun split-slash (path)
  (let ((text (if (and (plusp (length path)) (char= (char path 0) #\/))
                  (subseq path 1)
                  path)))
    (loop for start = 0 then (1+ end)
          for end = (position #\/ text :start start)
          unless (and end (= start end))
            collect (subseq text start end)
          while end)))

(defun canonical-uri (path)
  (format nil "/~{~A~^/~}" (mapcar #'aws-encode (split-slash path))))

(defun canonical-query (alist)
  (format nil "~{~A~^&~}"
          (mapcar (lambda (pair)
                    (format nil "~A=~A"
                            (aws-encode (car pair))
                            (aws-encode (cdr pair))))
                  (sort (copy-list alist) #'string< :key #'car))))

(defun canonical-request (method uri query-alist headers payload-hash)
  "The AWS SigV4 canonical request, and the signed-header list as the
second value.  HEADERS is an alist of lowercase names."
  (let* ((sorted (sort (copy-alist headers) #'string< :key #'car))
         (header-block (with-output-to-string (out)
                         (dolist (pair sorted)
                           (format out "~A:~A~%" (car pair) (cdr pair)))))
         (signed (format nil "~{~A~^;~}" (mapcar #'car sorted))))
    (values (format nil "~A~%~A~%~A~%~A~%~A~%~A"
                    method uri (canonical-query query-alist)
                    header-block signed payload-hash)
            signed)))

(defun sha256-hex (octets)
  (ironclad:byte-array-to-hex-string
   (ironclad:digest-sequence :sha256 octets)))

(defun hmac-sha256 (key data)
  (let ((hmac (ironclad:make-hmac key :sha256)))
    (ironclad:update-hmac hmac (if (stringp data)
                                   (babel:string-to-octets data :encoding :utf-8)
                                   data))
    (ironclad:hmac-digest hmac)))

(defun signing-key (secret datestamp region service)
  (let* ((seed (hmac-sha256 (babel:string-to-octets
                             (concatenate 'string "AWS4" secret)
                             :encoding :utf-8)
                            datestamp))
         (region-key (hmac-sha256 seed region))
         (service-key (hmac-sha256 region-key service)))
    (hmac-sha256 service-key "aws4_request")))

(defun s3-signature (&key method uri query headers payload-hash
                       amz-date datestamp secret-key region service)
  "Hex signature for one request.  Second value is the signed-header list.
Third value is the credential scope."
  (multiple-value-bind (canonical signed)
      (canonical-request method uri query headers payload-hash)
    (let* ((scope (format nil "~A/~A/~A/aws4_request" datestamp region service))
           (string-to-sign
             (format nil "AWS4-HMAC-SHA256~%~A~%~A~%~A"
                     amz-date scope
                     (sha256-hex (babel:string-to-octets canonical :encoding :utf-8))))
           (signature (ironclad:byte-array-to-hex-string
                       (hmac-sha256 (signing-key secret-key datestamp region service)
                                    string-to-sign))))
      (values signature signed scope))))

(behavior 's3-signature
  ;; AWS documentation example.  The secret is the published example key.
  (let ((headers '(("host" . "examplebucket.s3.amazonaws.com")
                   ("range" . "bytes=0-9")
                   ("x-amz-content-sha256" . "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")
                   ("x-amz-date" . "20130524T000000Z"))))
    (should-string=
     "f0e8bdb87c964420e857bd35b5d6ed310bd44f0170aba48dd91039c6036bdb41"
     (s3-signature :method "GET"
                   :uri "/test.txt"
                   :query '()
                   :headers headers
                   :payload-hash *empty-sha256*
                   :amz-date "20130524T000000Z"
                   :datestamp "20130524"
                   :secret-key "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
                   :region "us-east-1"
                   :service "s3"))))

(defun amz-timestamp (&optional (universal (get-universal-time)))
  "Values: 20130524T000000Z and 20130524, in UTC."
  (multiple-value-bind (second minute hour day month year)
      (decode-universal-time universal 0)
    (values (format nil "~4,'0D~2,'0D~2,'0DT~2,'0D~2,'0D~2,'0DZ"
                    year month day hour minute second)
            (format nil "~4,'0D~2,'0D~2,'0D" year month day))))

(defun require-s3 ()
  (unless (and (usable-key-p *s3-access-key*)
               (usable-key-p *s3-secret-key*))
    (error 'needs-key
           :url *s3-endpoint*
           :error-message
           "Flat files need the S3 access key and secret from https://massive.com/dashboard/keys. They are not the REST API key. Set *s3-access-key* and *s3-secret-key* in source/configuration/local-configuration.lisp, or MASSIVE_S3_ACCESS_KEY and MASSIVE_S3_SECRET_ACCESS_KEY.")))

(defun s3-endpoint-host ()
  (quri:uri-host (quri:uri *s3-endpoint*)))

(defun s3-request-url (uri-path query-alist)
  (let ((query (canonical-query query-alist))
        (base (string-right-trim "/" *s3-endpoint*)))
    (if (plusp (length query))
        (concatenate 'string base uri-path "?" query)
        (concatenate 'string base uri-path))))

(defun replace-string (string old new)
  (with-output-to-string (out)
    (loop with start = 0
          for pos = (search old string :start2 start)
          do (write-string string out :start start :end (or pos (length string)))
          while pos
          do (write-string new out)
             (setf start (+ pos (length old))))))

(defun xml-unescape (text)
  (let ((s text))
    (setf s (replace-string s "&quot;" "\""))
    (setf s (replace-string s "&apos;" "'"))
    (setf s (replace-string s "&lt;" "<"))
    (setf s (replace-string s "&gt;" ">"))
    (setf s (replace-string s "&amp;" "&"))
    s))

(defun xml-blocks (xml tag)
  "Inner text of each <TAG>...</TAG> in XML.  S3 uses unprefixed tags."
  (let ((open (concatenate 'string "<" tag ">"))
        (close (concatenate 'string "</" tag ">"))
        (pos 0)
        (out '()))
    (loop for start = (search open xml :start2 pos)
          while start
          for inner = (+ start (length open))
          for end = (search close xml :start2 inner)
          while end
          do (push (subseq xml inner end) out)
             (setf pos (+ end (length close))))
    (nreverse out)))

(defun xml-text (xml tag)
  (let ((blocks (xml-blocks xml tag)))
    (when blocks
      (xml-unescape
       (string-trim '(#\Space #\Tab #\Newline #\Return) (first blocks))))))

(defun parse-list-bucket (xml)
  "Plist from a ListObjectsV2 body: :objects :common-prefixes :truncated :next-token.
Each object is (:key :size :last-modified :storage-class)."
  (list :objects
        (mapcar (lambda (block)
                  (let ((size (xml-text block "Size")))
                    (list :key (xml-text block "Key")
                          :size (when size (parse-integer size :junk-allowed t))
                          :last-modified (xml-text block "LastModified")
                          :storage-class (xml-text block "StorageClass"))))
                (xml-blocks xml "Contents"))
        :common-prefixes
        (mapcar (lambda (block) (xml-text block "Prefix"))
                (xml-blocks xml "CommonPrefixes"))
        :truncated (string-equal (or (xml-text xml "IsTruncated") "") "true")
        :next-token (xml-text xml "NextContinuationToken")))

(defun s3-error-from (status body url)
  (let* ((text (ensure-text body))
         (code (when (and (stringp text) (search "<Code>" text))
                 (xml-text text "Code")))
         (message (when (and (stringp text) (search "<Message>" text))
                    (xml-text text "Message"))))
    (make-instance
     (cond ((or (and (integerp status) (= status 404))
                (and code (member code '("NoSuchKey" "NotFound") :test #'string-equal)))
            'not-found)
           ((and code (member code '("AccessDenied" "AllAccessDisabled")
                              :test #'string-equal))
            'plan-restricted)
           ((and (integerp status) (= status 401))
            'unauthorized)
           ((and (integerp status) (= status 429))
            'rate-limited)
           (t 'api-error))
     :status status
     :url url
     :error-code code
     :error-message (or message
                        (if (or (null text) (zerop (length text)))
                            (format nil "S3 HTTP status ~A with an empty body" status)
                            (format nil "S3 HTTP status ~A" status)))
     :body text)))

(behavior 'parse-list-bucket
  (let ((page (parse-list-bucket
               "<ListBucketResult>
                  <IsTruncated>false</IsTruncated>
                  <Contents><Key>us_stocks_sip/day_aggs_v1/2024/03/2024-03-01.csv.gz</Key><Size>200</Size><LastModified>2024-03-02T03:00:19.000Z</LastModified><StorageClass>STANDARD</StorageClass></Contents>
                  <CommonPrefixes><Prefix>us_stocks_sip/day_aggs_v1/</Prefix></CommonPrefixes>
                </ListBucketResult>")))
    (should-be-false (getf page :truncated))
    (should-be-null (getf page :next-token))
    (should-string= "us_stocks_sip/day_aggs_v1/"
                    (first (getf page :common-prefixes)))
    (should-string= "us_stocks_sip/day_aggs_v1/2024/03/2024-03-01.csv.gz"
                    (getf (first (getf page :objects)) :key))
    (should= 200 (getf (first (getf page :objects)) :size))))

(behavior 's3-error-from
  (let ((condition (s3-error-from
                    403
                    "<Error><Code>AccessDenied</Code><Message>nope</Message></Error>"
                    "https://files.massive.com/flatfiles/us_stocks_sip/")))
    (should-be-true (typep condition 'plan-restricted))
    (should-string= "AccessDenied" (api-error-code condition))
    (should-string= "nope" (api-error-message condition))))

(defun s3-http (path &key query output)
  "Signed GET of PATH on the flat-file endpoint.
QUERY is an alist.  OUTPUT, when given, is a pathname for the body.
Returns the body string, or OUTPUT."
  (require-s3)
  (multiple-value-bind (amz-date datestamp) (amz-timestamp)
    (let* ((headers (list (cons "host" (s3-endpoint-host))
                          (cons "x-amz-content-sha256" *empty-sha256*)
                          (cons "x-amz-date" amz-date)))
           (uri-path (canonical-uri path))
           (url (s3-request-url uri-path query)))
      (multiple-value-bind (signature signed scope)
          (s3-signature :method "GET"
                        :uri uri-path
                        :query query
                        :headers headers
                        :payload-hash *empty-sha256*
                        :amz-date amz-date
                        :datestamp datestamp
                        :secret-key *s3-secret-key*
                        :region *s3-region*
                        :service "s3")
        (let ((http-headers
                (append headers
                        (list (cons "Authorization"
                                    (format nil "AWS4-HMAC-SHA256 Credential=~A/~A, SignedHeaders=~A, Signature=~A"
                                            *s3-access-key* scope signed signature))))))
          (labels ((once ()
                     (if output
                         (with-open-file (out output
                                              :direction :output
                                              :element-type '(unsigned-byte 8)
                                              :if-exists :supersede
                                              :if-does-not-exist :create)
                           (let ((in (dex:get url
                                              :headers http-headers
                                              :force-binary t
                                              :want-stream t
                                              :max-redirects 0
                                              :connect-timeout *s3-timeout-seconds*
                                              :read-timeout *s3-timeout-seconds*)))
                             (unwind-protect
                                  (uiop:copy-stream-to-stream
                                   in out :element-type '(unsigned-byte 8))
                               (close in)))
                           output)
                         (dex:get url
                                  :headers http-headers
                                  :max-redirects 0
                                  :connect-timeout *s3-timeout-seconds*
                                  :read-timeout *s3-timeout-seconds*))))
            (loop for attempt from 1 to (max 1 *max-retries*)
                  do (handler-case
                         (return (once))
                       (error (condition)
                         (let ((status (http-status condition)))
                           (cond ((null status)
                                  (error condition))
                                 ((and (member status '(429 500 503))
                                       (< attempt *max-retries*))
                                  (sleep (* *retry-wait-seconds* attempt)))
                                 (t
                                  (error (s3-error-from status
                                                        (http-body condition)
                                                        url))))))))))))))

(defun list-query (prefix delimiter max-keys token)
  (remove nil
          (list (cons "list-type" "2")
                (and prefix (plusp (length prefix)) (cons "prefix" prefix))
                (and delimiter (cons "delimiter" delimiter))
                (and max-keys (cons "max-keys" (princ-to-string max-keys)))
                (and token (cons "continuation-token" token)))))

(defun canonicalize-list-prefix (prefix)
  (cond ((null prefix) "")
        ((or (keywordp prefix) (flat-dataset-p prefix))
         (concatenate 'string (flat-dataset-prefix (flat-dataset prefix)) "/"))
        (t prefix)))

(defun list-flat-files-page (&key prefix delimiter max-keys continuation-token)
  (parse-list-bucket
   (ensure-text
    (s3-http (concatenate 'string "/" *s3-bucket*)
             :query (list-query prefix delimiter max-keys continuation-token)))))

(defun list-flat-files (&key prefix delimiter (max-keys 1000) continuation-token
                          (follow nil) (max-pages *max-pages*))
  "ListObjectsV2 on the flat-file bucket.
PREFIX may be a string, a dataset keyword, or a FLAT-DATASET.
DELIMITER \"/\" returns directory-style :COMMON-PREFIXES.
FOLLOW walks continuation tokens up to MAX-PAGES."
  (let* ((prefix (canonicalize-list-prefix prefix))
         (page (list-flat-files-page :prefix prefix
                                     :delimiter delimiter
                                     :max-keys max-keys
                                     :continuation-token continuation-token)))
    (if (not follow)
        page
        (let ((objects (getf page :objects))
              (prefixes (getf page :common-prefixes))
              (token (getf page :next-token)))
          (loop for n from 1
                while (and token (< n max-pages))
                for next = (list-flat-files-page :prefix prefix
                                                 :delimiter delimiter
                                                 :max-keys max-keys
                                                 :continuation-token token)
                do (setf objects (append objects (getf next :objects))
                         prefixes (append prefixes (getf next :common-prefixes))
                         token (getf next :next-token)))
          (list :objects objects
                :common-prefixes prefixes
                :truncated (and token t)
                :next-token token)))))

(defun download-flat-object (key pathname)
  "Download one object to PATHNAME.  KEY is relative to the bucket.
Returns PATHNAME."
  (s3-http (concatenate 'string "/" *s3-bucket* "/" key) :output pathname)
  pathname)

(defun download-flat-file (dataset date pathname)
  "Download one day's gzip to PATHNAME.  Returns PATHNAME."
  (download-flat-object (flat-object-key dataset date) pathname))

(defun call-with-flat-object (key function)
  "Download KEY to a temporary file, call FUNCTION on the pathname, then delete it."
  (let ((path (merge-pathnames
               (format nil "massive-flat-~A.gz" (random 1000000000))
               (uiop:temporary-directory))))
    (unwind-protect
         (progn
           (download-flat-object key path)
           (funcall function path))
      (when (probe-file path)
        (delete-file path)))))

(defun map-flat-file (dataset date function &key ticker)
  "Download DATE's file and call FUNCTION with each row plist.
TICKER keeps one symbol.  Returns the number of rows passed to FUNCTION.
The gzip is deleted afterwards.  A minute or trade file is the whole market
for that day; the filter does not make the download smaller."
  (call-with-flat-object
   (flat-object-key dataset date)
   (lambda (path)
     (map-gzip-csv path function :ticker ticker))))

(defun read-flat-file (dataset date &key ticker)
  "Every row of one day's file, as plists.
Prefer MAP-FLAT-FILE.  A collected minute, quote, or trade file is large."
  (let ((rows '()))
    (map-flat-file dataset date
                   (lambda (row) (push row rows))
                   :ticker ticker)
    (nreverse rows)))
