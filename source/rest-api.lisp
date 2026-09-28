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

;;; Skip DEFPACKAGE when the package already exists.  ENDPOINTS adds its
;;; names with EXPORT, and re-evaluating this list on TEST-OP would make
;;; SBCL warn that the package exports more than the form lists.
(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package '#:massive/rest-api)
    (defpackage #:massive/rest-api
      (:use #:common-lisp #:sigma/behave)
      (:export
   #:*api*
   #:*api-key*
   #:*s3-access-key*
   #:*s3-secret-key*
   #:*s3-endpoint*
   #:*s3-bucket*
   #:*s3-region*
   #:*user-agent*
   #:*api-cache-timeout-seconds*
   #:*request-timeout-seconds*
   #:*max-retries*
   #:*retry-wait-seconds*
   #:*max-pages*
   #:*placeholder-keys*
   #:use-key
   #:use-keyless
   #:local-configuration-path
   #:reload-local-configuration
   #:configure-from-environment
   #:usable-key-p
   #:query-value
   #:query
   #:query-alist
   #:canonicalize-ticker
   #:canonicalize-timespan
   #:canonicalize-date
   #:canonicalize-window
   #:path-segment
   #:ticker-segment
   #:timespan-segment
   #:unix-epoch
   #:unix->universal
   #:universal->unix
   #:timestamp->universal
   #:parse-iso-8601
   #:request-url
   #:normalize-next-url
   #:next-url
   #:append-page
   #:follow-pages
   #:json-elt
   #:json-ref
   #:json-list
   #:json-number
   #:json-true-p
   #:http-status
   #:http-body
   #:http-get
   #:http-get-json
   #:http-get-json-cached
   #:http-get-json-do-not-cache
   #:api-get
   #:ensure-text
   #:uri-string
   #:api-error
   #:rate-limited
   #:unauthorized
   #:plan-restricted
   #:not-found
   #:needs-key
   #:api-error-status
   #:api-error-url
   #:api-error-code
   #:api-error-message
   #:api-error-body
   #:classify-error
   #:api-error-from))))
(in-package #:massive/rest-api)

(defvar *api* "https://api.massive.com"
  "REST origin.  Paths start with /v1, /v2, /v3, /fed, /futures, and so on.
api.polygon.io still answers the same paths.")

(defvar *api-key* nil
  "REST key.  Sent as Authorization: Bearer, never as a query parameter.
On load, source/configuration/local-configuration.lisp sets this when that
file exists.  Otherwise MASSIVE_API_KEY.")

(defvar *s3-access-key* nil
  "Flat-file S3 access key from the Massive dashboard.  This is not the REST key.")
(defvar *s3-secret-key* nil
  "Flat-file S3 secret key from the Massive dashboard.")
(defvar *s3-endpoint* "https://files.massive.com")
(defvar *s3-bucket* "flatfiles")
(defvar *s3-region* "us-east-1")

(defvar *user-agent* "massive/0.1.0 (Common Lisp)")
(defvar *api-cache-timeout-seconds* 60
  "How long HTTP-GET-JSON-CACHED keeps a response.")
(defvar *request-timeout-seconds* 30)
(defvar *max-retries* 3
  "Attempts for HTTP 429.  Other statuses are not retried.")
(defvar *retry-wait-seconds* 5
  "Base wait between 429 retries.  Attempt N waits N times this, unless
Retry-After is shorter.  Retry-After above 30 seconds is not slept.")
(defvar *max-pages* 20
  "Default page cap for :FOLLOW.  The first page counts as one.")

(defvar *placeholder-keys*
  '("YOUR_API_KEY" "your_api_key" "your-api-key" "YOUR_ACCESS_KEY_ID"
    "YOUR_SECRET_ACCESS_KEY" "changeme" "xxx" "none" "null" "undefined")
  "Copy-paste placeholders.  USABLE-KEY-P treats these as no key.")

(defparameter *success-statuses* '("OK" "DELAYED")
  "Payload status strings that are not errors.  Market status has no status field.")

(defun use-key (key)
  "Use KEY for REST calls.  Returns KEY."
  (setf *api-key* key))

(defun use-keyless ()
  "Clear *API-KEY*.  Massive has no keyless REST calls."
  (setf *api-key* nil))

(defun local-configuration-path ()
  "Gitignored Lisp file that may rebind *API-KEY* and the S3 parameters.
Loaded in this package."
  (merge-pathnames #P"source/configuration/local-configuration.lisp"
                   (asdf:system-source-directory :massive)))

(defun reload-local-configuration ()
  "Load the local configuration file when it exists.  Returns the pathname
or NIL."
  (let ((path (local-configuration-path)))
    (when (probe-file path)
      (load path)
      path)))

(defun placeholder-key-p (key)
  (or (search "${" key)
      (member key *placeholder-keys* :test #'string-equal)))

(defun usable-key-p (key)
  "True when KEY can be sent.
Empty, whitespace, control characters, unexpanded ${...} templates,
and the documented placeholders are not keys."
  (and (stringp key)
       (plusp (length key))
       (not (find-if (lambda (char)
                       (or (char= char #\Space)
                           (char= char #\Tab)
                           (char= char #\Newline)
                           (char= char #\Return)
                           (< (char-code char) 32)))
                     key))
       (not (placeholder-key-p key))))

(defun configure-from-environment ()
  "Fill any unset key from the process environment.
A value already loaded from local-configuration.lisp wins.
REST: MASSIVE_API_KEY.
S3: MASSIVE_S3_ACCESS_KEY / MASSIVE_S3_SECRET_ACCESS_KEY,
or MASSIVE_FILES_ACCESS_KEY / MASSIVE_FILES_SECRET_ACCESS_KEY."
  (unless (usable-key-p *api-key*)
    (let ((key (uiop:getenv "MASSIVE_API_KEY")))
      (when (usable-key-p key)
        (setf *api-key* key))))
  (unless (usable-key-p *s3-access-key*)
    (let ((key (or (uiop:getenv "MASSIVE_S3_ACCESS_KEY")
                   (uiop:getenv "MASSIVE_FILES_ACCESS_KEY"))))
      (when (usable-key-p key)
        (setf *s3-access-key* key))))
  (unless (usable-key-p *s3-secret-key*)
    (let ((key (or (uiop:getenv "MASSIVE_S3_SECRET_ACCESS_KEY")
                   (uiop:getenv "MASSIVE_FILES_SECRET_ACCESS_KEY"))))
      (when (usable-key-p key)
        (setf *s3-secret-key* key))))
  *api-key*)

(defun require-key ()
  "Signal NEEDS-KEY when *API-KEY* is not usable."
  (unless (usable-key-p *api-key*)
    (error 'needs-key
           :url *api*
           :error-message
           "This request needs a Massive API key. Put (defparameter *api-key* \"...\") in source/configuration/local-configuration.lisp, or set MASSIVE_API_KEY. Keys are at https://massive.com/dashboard/keys.")))

(behavior 'usable-key-p
  (should-be-false (usable-key-p nil))
  (should-be-false (usable-key-p ""))
  (should-be-false (usable-key-p "YOUR_API_KEY"))
  (should-be-false (usable-key-p "${MASSIVE_API_KEY}"))
  (should-be-false (usable-key-p "abc def"))
  (should-be-true (usable-key-p "abc_DEF-123")))

(behavior 'use-key
  (let ((*api-key* nil))
    (use-key "abc_DEF-123")
    (should-string= "abc_DEF-123" *api-key*)
    (use-keyless)
    (should-be-null *api-key*)))

;;;; -- Query and paths -------------------------------------------------------

(defun query-value (value)
  "A Lisp value as a Massive query fragment.
NIL omits the parameter.  T and :TRUE are true.  :FALSE is false.
Symbols are downcased, so :ASC is asc and :DATE.ASC is date.asc.
Strings pass through unchanged.  Lists become comma-separated."
  (cond ((or (eq value t) (eq value :true)) "true")
        ((eq value :false) "false")
        ((null value) nil)
        ((stringp value) value)
        ((symbolp value) (string-downcase (symbol-name value)))
        ((integerp value) (princ-to-string value))
        ((floatp value) (format nil "~F" value))
        ((and (vectorp value) (not (stringp value)))
         (query-value (coerce value 'list)))
        ((listp value)
         (let ((parts (remove nil (mapcar #'query-value value))))
           (when parts
             (format nil "~{~A~^,~}" parts))))
        (t (princ-to-string value))))

(defun query (&rest pairs)
  "Build ((NAME VALUE) ...) from NAME VALUE ..., dropping NILs.
Proper lists so function-cache can hash them.  HTTP-GET turns them
into an alist for QURI."
  (loop for (name value) on pairs by #'cddr
        for rendered = (query-value value)
        when rendered
          collect (list name rendered)))

(defun query-alist (query-args)
  (mapcar (lambda (pair)
            (if (and (consp pair) (consp (cdr pair)))
                (cons (first pair) (second pair))
                pair))
          query-args))

(defun split-on (string char)
  (loop for start = 0 then (1+ end)
        for end = (position char string :start start)
        collect (subseq string start end)
        while end))

(defun encode-path-segment (string)
  "URL-encode STRING, but keep colons.  Massive tickers look like X:BTCUSD."
  (unless (and (stringp string) (plusp (length string)))
    (error "Massive path segment is empty."))
  (format nil "~{~A~^:~}"
          (mapcar #'quri:url-encode (split-on string #\:))))

(defun path-segment (value)
  "Encode a path segment.  Symbols are downcased.  Strings pass through."
  (encode-path-segment
   (cond ((stringp value) value)
         ((symbolp value) (string-downcase (symbol-name value)))
         ((integerp value) (princ-to-string value))
         ((numberp value) (format nil "~F" value))
         (t (princ-to-string value)))))

(defun canonicalize-ticker (value)
  "Uppercase a ticker, or a list of them.  Strings keep their punctuation,
so \"brk.b\" is BRK.B and \"x:btcusd\" is X:BTCUSD."
  (cond ((null value) nil)
        ((stringp value) (string-upcase value))
        ((symbolp value) (string-upcase (symbol-name value)))
        ((and (vectorp value) (not (stringp value)))
         (canonicalize-ticker (coerce value 'list)))
        ((listp value) (mapcar #'canonicalize-ticker value))
        (t (string-upcase (princ-to-string value)))))

(defun ticker-segment (value)
  (encode-path-segment (or (canonicalize-ticker value)
                           (error "Massive ticker is empty."))))

(defun canonicalize-timespan (value)
  "Massive aggregate unit: second, minute, hour, day, week, month,
quarter, year, or session.  Candlestick short names are accepted.
\"5m\" is not a timespan; the 5 belongs in the multiplier."
  (when value
    (let ((s (string-downcase
              (if (symbolp value)
                  (symbol-name value)
                  (princ-to-string value)))))
      (cond ((member s '("s" "sec" "second" "seconds" "1s" "1sec") :test #'string=)
             "second")
            ((member s '("m" "min" "minute" "minutes" "1m" "1min") :test #'string=)
             "minute")
            ((member s '("h" "hr" "hour" "hours" "hourly" "1h") :test #'string=)
             "hour")
            ((member s '("d" "day" "days" "daily" "1d") :test #'string=)
             "day")
            ((member s '("w" "wk" "week" "weeks" "weekly" "1wk") :test #'string=)
             "week")
            ((member s '("mo" "month" "months" "monthly" "1mo") :test #'string=)
             "month")
            ((member s '("q" "quarter" "1q") :test #'string=)
             "quarter")
            ((member s '("y" "yr" "year" "yearly" "1y") :test #'string=)
             "year")
            ((member s '("session" "1session") :test #'string=)
             "session")
            (t s)))))

(defun timespan-segment (value)
  (path-segment (or (canonicalize-timespan value)
                    (error "Massive timespan is empty."))))

(behavior 'query-value
  (should-string= "true" (query-value t))
  (should-string= "false" (query-value :false))
  (should-string= "asc" (query-value :asc))
  (should-string= "date.asc" (query-value :date.asc))
  (should-string= "AAPL" (query-value "AAPL"))
  (should-string= "AAPL,MSFT" (query-value '("AAPL" "MSFT")))
  (should-be-null (query-value nil))
  (should-be-false (search "d" (query-value 1.5d0))))

(behavior 'query
  (should-equal '(("adjusted" "false") ("sort" "asc"))
                (query "adjusted" :false "sort" :asc "limit" nil))
  (should-be-null (query "missing" nil)))

(behavior 'canonicalize-ticker
  (should-string= "AAPL" (canonicalize-ticker :aapl))
  (should-string= "X:BTCUSD" (canonicalize-ticker "x:btcusd"))
  (should-string= "BRK.B" (canonicalize-ticker "brk.b"))
  (should-equal '("AAPL" "MSFT") (canonicalize-ticker '(:aapl :msft)))
  (should-be-null (canonicalize-ticker nil)))

(behavior 'path-segments
  (should-string= "X:BTCUSD" (ticker-segment "x:btcusd"))
  (should-string= "BRK.B" (ticker-segment "brk.b"))
  (should-string= "day" (timespan-segment :d))
  (should-string= "minute" (timespan-segment "1m"))
  (should-string= "gainers" (path-segment :gainers)))

(behavior 'canonicalize-timespan
  (should-string= "day" (canonicalize-timespan :day))
  (should-string= "week" (canonicalize-timespan "1wk"))
  (should-string= "session" (canonicalize-timespan "session"))
  (should-be-null (canonicalize-timespan nil)))

;;;; -- Time ------------------------------------------------------------------

(defparameter unix-epoch (encode-universal-time 0 0 0 1 1 1970 0)
  "Universal time of 1970-01-01T00:00:00Z.")

(defun unix->universal (unix)
  "UNIX seconds or milliseconds to universal time.
Values above 10^11 are milliseconds."
  (when (numberp unix)
    (let ((seconds (if (> unix 100000000000)
                       (floor unix 1000)
                       (floor unix))))
      (+ seconds unix-epoch))))

(defun universal->unix (universal)
  "Universal time to UNIX seconds."
  (- universal unix-epoch))

(defun iso-offset-seconds (rest)
  "Seconds east of UTC in the suffix of an ISO-8601 timestamp."
  (let ((pos (position-if (lambda (char)
                            (member char '(#\Z #\z #\+ #\-) :test #'char=))
                          rest)))
    (cond ((or (null pos)
               (char= (char rest pos) #\Z)
               (char= (char rest pos) #\z))
           0)
          (t
           (let* ((sign (if (char= (char rest pos) #\-) -1 1))
                  (digits (subseq rest (1+ pos)))
                  (hour 0)
                  (minute 0))
             (cond ((and (>= (length digits) 5)
                         (char= (char digits 2) #\:))
                    (setf hour (parse-integer digits :start 0 :end 2)
                          minute (parse-integer digits :start 3 :end 5)))
                   ((>= (length digits) 4)
                    (setf hour (parse-integer digits :start 0 :end 2)
                          minute (parse-integer digits :start 2 :end 4)))
                   ((>= (length digits) 2)
                    (setf hour (parse-integer digits :end 2))))
             (* sign (+ (* hour 3600) (* minute 60))))))))

(defun parse-iso-8601 (string)
  "Universal time of an ISO-8601 timestamp.  Fractional seconds are truncated.
NIL when STRING is not a timestamp."
  (when (and (stringp string) (>= (length string) 19))
    (handler-case
        (let ((year (parse-integer string :start 0 :end 4))
              (month (parse-integer string :start 5 :end 7))
              (day (parse-integer string :start 8 :end 10))
              (hour (parse-integer string :start 11 :end 13))
              (minute (parse-integer string :start 14 :end 16))
              (second (parse-integer string :start 17 :end 19)))
          (unless (and (char= (char string 4) #\-)
                       (char= (char string 7) #\-)
                       (member (char string 10) '(#\T #\t) :test #'char=)
                       (char= (char string 13) #\:)
                       (char= (char string 16) #\:))
            (return-from parse-iso-8601 nil))
          (- (encode-universal-time second minute hour day month year 0)
             (iso-offset-seconds (subseq string 19))))
      (error () nil))))

(defun timestamp->universal (value)
  "Universal time from a Massive timestamp.
17+ digit integers are nanoseconds, 14+ are microseconds, 11+ are
milliseconds, values above 3e9 are already universal, and smaller
integers are UNIX seconds.  YYYY-MM-DD is UTC midnight.  Longer
ISO-8601 strings are parsed."
  (cond ((null value) nil)
        ((and (stringp value) (find #\T value :test #'char-equal))
         (parse-iso-8601 value))
        ((and (stringp value)
              (>= (length value) 10)
              (char= (char value 4) #\-)
              (char= (char value 7) #\-))
         (encode-universal-time 0 0 0
                                (parse-integer value :start 8 :end 10)
                                (parse-integer value :start 5 :end 7)
                                (parse-integer value :start 0 :end 4)
                                0))
        ((and (stringp value)
              (plusp (length value))
              (every #'digit-char-p value))
         (timestamp->universal (parse-integer value)))
        ((not (integerp value)) nil)
        ((>= value 100000000000000000)
         (unix->universal (floor value 1000000000)))
        ((>= value 100000000000000)
         (unix->universal (floor value 1000000)))
        ((>= value 100000000000)
         (unix->universal value))
        ((>= value 3000000000) value)
        (t (unix->universal value))))

(defun canonicalize-date (date)
  "YYYY-MM-DD.  Accepts that string, a (year month day) list, a universal
time, or a UNIX time."
  (cond ((null date) nil)
        ((and (stringp date)
              (>= (length date) 10)
              (char= (char date 4) #\-)
              (char= (char date 7) #\-))
         (subseq date 0 10))
        ((stringp date) date)
        ((and (consp date) (= 3 (length date)))
         (format nil "~4,'0D-~2,'0D-~2,'0D"
                 (first date) (second date) (third date)))
        ((integerp date)
         (multiple-value-bind (second minute hour day month year)
             (decode-universal-time (timestamp->universal date) 0)
           (declare (ignore second minute hour))
           (format nil "~4,'0D-~2,'0D-~2,'0D" year month day)))
        (t (princ-to-string date))))

(defun time-unix-seconds (n)
  "N as UNIX seconds.  Same digit thresholds as TIMESTAMP->UNIVERSAL."
  (cond ((>= n 100000000000000000) (floor n 1000000000))
        ((>= n 100000000000000) (floor n 1000000))
        ((>= n 100000000000) (floor n 1000))
        ((>= n 3000000000) (- n unix-epoch))
        (t n)))

(defun canonicalize-window (value &key (unit :ms))
  "Aggregate from/to value.
A date string or (year month day) list stays a YYYY-MM-DD date.
An integer becomes milliseconds (:MS, the v2 aggregate window) or
nanoseconds (:NS, the futures window).  NIL stays NIL."
  (cond ((null value) nil)
        ((and (consp value) (= 3 (length value)) (every #'integerp value))
         (format nil "~4,'0D-~2,'0D-~2,'0D"
                 (first value) (second value) (third value)))
        ((and (stringp value)
              (plusp (length value))
              (every #'digit-char-p value))
         (canonicalize-window (parse-integer value) :unit unit))
        ((stringp value) value)
        ((integerp value)
         (princ-to-string
          (* (time-unix-seconds value)
             (ecase unit
               (:ms 1000)
               (:ns 1000000000)))))
        (t (princ-to-string value))))

(behavior 'timestamp->universal
  (should= (unix->universal 1700000000)
           (timestamp->universal 1700000000))
  (should= (unix->universal 1700000000)
           (timestamp->universal 1700000000000))
  (should= (unix->universal 1700000000)
           (timestamp->universal 1700000000000000000))
  (should= (encode-universal-time 0 0 0 2 1 2024 0)
           (timestamp->universal "2024-01-02"))
  (should= (encode-universal-time 0 0 0 1 1 1970 0)
           (parse-iso-8601 "1970-01-01T00:00:00Z")))

(behavior 'canonicalize-window
  (should-string= "1700000000000" (canonicalize-window 1700000000))
  (should-string= "1700000000000" (canonicalize-window 1700000000000))
  (should-string= "1700000000000" (canonicalize-window 1700000000000000000))
  (should-string= "1700000000000"
                  (canonicalize-window (+ 1700000000 unix-epoch)))
  (should-string= "1700000000000000000"
                  (canonicalize-window 1700000000 :unit :ns))
  (should-string= "2024-01-02" (canonicalize-window '(2024 1 2)))
  (should-string= "2024-01-02" (canonicalize-window "2024-01-02"))
  (should-string= "2024-01-02" (canonicalize-date '(2024 1 2)))
  (should-be-null (canonicalize-window nil)))

;;;; -- JSON ------------------------------------------------------------------

(defun json-elt (seq index)
  (cond ((null seq) nil)
        ((and (stringp seq) (integerp index)) nil)
        ((and (vectorp seq) (integerp index) (< -1 index (length seq)))
         (aref seq index))
        ((and (listp seq) (integerp index))
         (nth index seq))
        (t nil)))

(defun json-ref (object &rest keys)
  "Walk OBJECT by string keys and integer indexes.  Missing steps are NIL."
  (dolist (key keys object)
    (setf object
          (cond ((null object) nil)
                ((integerp key) (json-elt object key))
                ((hash-table-p object) (gethash key object))
                (t nil)))))

(defun json-list (value)
  "A JSON array as a list.  NIL and strings are not lists of characters."
  (cond ((null value) nil)
        ((stringp value) (list value))
        ((vectorp value) (coerce value 'list))
        ((listp value) value)
        (t (list value))))

(defun json-number (value)
  (and (numberp value) value))

(defun json-true-p (value)
  "True for JSON true.  Yason yields T or YASON:TRUE depending on
*PARSE-JSON-BOOLEANS-AS-SYMBOLS*."
  (or (eq value t)
      (eq value :true)
      (eq value yason:true)))

(defun json-sequence-p (value)
  (or (and (vectorp value) (not (stringp value)))
      (and (listp value) (not (symbolp value)))))

(defun copy-json-table (table)
  (let ((copy (make-hash-table :test (hash-table-test table)
                               :size (hash-table-count table))))
    (maphash (lambda (key value) (setf (gethash key copy) value)) table)
    copy))

(defun next-url (payload)
  "The next_url string on a Massive page, or NIL."
  (when (hash-table-p payload)
    (let ((url (gethash "next_url" payload)))
      (when (and (stringp url) (plusp (length url)))
        url))))

(defun append-page (base page)
  "Shallow-copy BASE and append PAGE's results vector.  Does not mutate BASE.
count and resultsCount become the combined length when they were numbers.
next_url is the later page's cursor, or removed when the later page has none."
  (let ((merged (copy-json-table base)))
    (when (and (json-sequence-p (gethash "results" base))
               (json-sequence-p (gethash "results" page)))
      (let ((rows (concatenate 'vector
                               (coerce (gethash "results" base) 'vector)
                               (coerce (gethash "results" page) 'vector))))
        (setf (gethash "results" merged) rows)
        (when (numberp (gethash "resultsCount" merged))
          (setf (gethash "resultsCount" merged) (length rows)))
        (when (numberp (gethash "count" merged))
          (setf (gethash "count" merged) (length rows)))))
    (let ((url (next-url page)))
      (if url
          (setf (gethash "next_url" merged) url)
          (remhash "next_url" merged)))
    merged))

(behavior 'append-page
  (let ((base (make-hash-table :test #'equal))
        (page (make-hash-table :test #'equal)))
    (setf (gethash "results" base) #(a)
          (gethash "count" base) 1
          (gethash "next_url" base) "https://api.massive.com/next"
          (gethash "results" page) #(b))
    (let ((merged (append-page base page)))
      (should= 2 (length (gethash "results" merged)))
      (should= 2 (gethash "count" merged))
      (should-be-null (next-url merged))
      (should= 1 (length (gethash "results" base)))
      (should-string= "https://api.massive.com/next" (next-url base)))))

;;;; -- Errors ----------------------------------------------------------------

(define-condition api-error (error)
  ((status :initform nil :initarg :status :reader api-error-status)
   (url :initform nil :initarg :url :reader api-error-url)
   (error-code :initform nil :initarg :error-code :reader api-error-code)
   (error-message :initform nil :initarg :error-message :reader api-error-message)
   (body :initform nil :initarg :body :reader api-error-body))
  (:report (lambda (condition stream)
             (format stream "Massive API error [HTTP ~A~A]: ~A (url: ~A)"
                     (or (api-error-status condition) "?")
                     (if (api-error-code condition)
                         (format nil ", ~A" (api-error-code condition))
                         "")
                     (or (api-error-message condition) "unknown error")
                     (or (api-error-url condition) "?"))))
  (:documentation "An error returned by Massive.
STATUS is the HTTP status, or NIL for a failure carried in a 200 body.
ERROR-CODE is the payload status string (NOT_AUTHORIZED, NOT_FOUND, ERROR).
URL is the request URI without the API key.  BODY is the response body."))

(define-condition rate-limited (api-error) ()
  (:documentation "HTTP 429, or a body that says the per-minute cap was hit."))

(define-condition unauthorized (api-error) ()
  (:documentation "HTTP 401.  The REST key was missing or unknown."))

(define-condition plan-restricted (api-error) ()
  (:documentation "HTTP 403, or status NOT_AUTHORIZED.  The plan does not
include this endpoint or this date range."))

(define-condition not-found (api-error) ()
  (:documentation "HTTP 404, or status NOT_FOUND."))

(define-condition needs-key (api-error) ()
  (:report (lambda (condition stream)
             (format stream "~A"
                     (or (api-error-message condition)
                         "A Massive API key is required."))))
  (:documentation "A call was made with no usable key."))

(defun http-status (condition)
  (let ((fn (or (and (find-symbol "RESPONSE-STATUS" :dexador)
                     (fboundp (find-symbol "RESPONSE-STATUS" :dexador))
                     (symbol-function (find-symbol "RESPONSE-STATUS" :dexador)))
                (and (find-symbol "RESPONSE-STATUS" :dex)
                     (fboundp (find-symbol "RESPONSE-STATUS" :dex))
                     (symbol-function (find-symbol "RESPONSE-STATUS" :dex))))))
    (when fn
      (ignore-errors (funcall fn condition)))))

(defun http-body (condition)
  (let ((fn (or (and (find-symbol "RESPONSE-BODY" :dexador)
                     (fboundp (find-symbol "RESPONSE-BODY" :dexador))
                     (symbol-function (find-symbol "RESPONSE-BODY" :dexador)))
                (and (find-symbol "RESPONSE-BODY" :dex)
                     (fboundp (find-symbol "RESPONSE-BODY" :dex))
                     (symbol-function (find-symbol "RESPONSE-BODY" :dex))))))
    (when fn
      (ignore-errors (funcall fn condition)))))

(defun http-headers (condition)
  (let ((fn (or (and (find-symbol "RESPONSE-HEADERS" :dexador)
                     (fboundp (find-symbol "RESPONSE-HEADERS" :dexador))
                     (symbol-function (find-symbol "RESPONSE-HEADERS" :dexador)))
                (and (find-symbol "RESPONSE-HEADERS" :dex)
                     (fboundp (find-symbol "RESPONSE-HEADERS" :dex))
                     (symbol-function (find-symbol "RESPONSE-HEADERS" :dex))))))
    (when fn
      (ignore-errors (funcall fn condition)))))

(defun ensure-text (body)
  (cond ((or (null body) (stringp body)) body)
        ((typep body '(vector (unsigned-byte 8)))
         (map 'string #'code-char body))
        (t (princ-to-string body))))

(defun parse-json (text)
  (let ((yason:*parse-json-arrays-as-vectors* t)
        (yason:*parse-json-booleans-as-symbols* t))
    (yason:parse text)))

(defun error-fields (body)
  "MESSAGE, status CODE, and REQUEST-ID from a Massive error body."
  (let ((top (cond ((hash-table-p body) body)
                   ((stringp body)
                    (let ((text (string-left-trim '(#\Space #\Tab #\Newline #\Return)
                                                  body)))
                      (when (and (plusp (length text))
                                 (char= (char text 0) #\{))
                        (ignore-errors (parse-json text)))))
                   (t nil))))
    (when (hash-table-p top)
      (values (or (gethash "message" top)
                  (gethash "error" top))
              (gethash "status" top)
              (gethash "request_id" top)))))

(defun classify-error (status code message)
  "Pick the api-error subclass for HTTP STATUS and payload CODE/MESSAGE."
  (cond ((or (and (integerp status) (= status 429))
             (and (stringp message)
                  (search "maximum requests" message :test #'char-equal)))
         'rate-limited)
        ((or (and (integerp status) (= status 401))
             (and (stringp message)
                  (search "Unknown API Key" message :test #'char-equal)))
         'unauthorized)
        ((or (and (integerp status) (= status 403))
             (and (stringp code) (string-equal code "NOT_AUTHORIZED")))
         'plan-restricted)
        ((or (and (integerp status) (= status 404))
             (and (stringp code) (string-equal code "NOT_FOUND")))
         'not-found)
        (t 'api-error)))

(defun uri-string (uri)
  (if (stringp uri)
      uri
      (quri:render-uri uri)))

(defun api-error-from (status body url)
  "Build the api-error for HTTP STATUS and response BODY."
  (multiple-value-bind (message code request-id) (error-fields body)
    (declare (ignore request-id))
    (let ((url (uri-string url)))
      (make-instance (classify-error status code message)
                     :status status
                     :url url
                     :error-code code
                     :error-message (or message
                                        (format nil "HTTP status ~A from ~A"
                                                status url))
                     :body (ensure-text body)))))

(defun header-value (headers name)
  (cond ((hash-table-p headers)
         (or (gethash name headers)
             (gethash (string-downcase name) headers)
             (loop for key being the hash-keys of headers
                     using (hash-value value)
                   when (and (stringp key) (string-equal key name))
                     return value)))
        ((listp headers)
         (cdr (assoc name headers :test #'string-equal)))))

(defun retry-after-seconds (condition)
  "Retry-After in seconds, when it is an integer from 1 to 30."
  (let* ((headers (http-headers condition))
         (raw (and headers (header-value headers "retry-after"))))
    (when (and (stringp raw) (plusp (length raw)) (every #'digit-char-p raw))
      (let ((n (parse-integer raw)))
        (when (<= 1 n 30) n)))))

(defun payload-failure (payload)
  "A payload status that is not OK or DELAYED, or NIL."
  (when (hash-table-p payload)
    (let ((status (gethash "status" payload)))
      (when (and (stringp status)
                 (not (member status *success-statuses* :test #'string-equal)))
        status))))

(behavior 'classify-error
  (should-eq 'rate-limited (classify-error 429 "ERROR" "slow down"))
  (should-eq 'rate-limited
             (classify-error 200 "ERROR"
                             "You've exceeded the maximum requests per minute"))
  (should-eq 'unauthorized (classify-error 401 "ERROR" "Unknown API Key"))
  (should-eq 'plan-restricted (classify-error 403 "NOT_AUTHORIZED" "upgrade"))
  (should-eq 'plan-restricted (classify-error nil "NOT_AUTHORIZED" "upgrade"))
  (should-eq 'not-found (classify-error 404 "NOT_FOUND" "Ticker not found."))
  (should-eq 'api-error (classify-error 400 "ERROR" "bad")))

(behavior 'api-error-from
  (let ((condition
          (api-error-from
           403
           "{\"status\":\"NOT_AUTHORIZED\",\"message\":\"upgrade\",\"request_id\":\"abc\"}"
           "https://api.massive.com/v2/aggs/ticker/AAPL/prev")))
    (should-be-true (typep condition 'plan-restricted))
    (should= 403 (api-error-status condition))
    (should-string= "NOT_AUTHORIZED" (api-error-code condition))
    (should-string= "upgrade" (api-error-message condition))
    (should-be-false (search "apiKey" (api-error-url condition)))))

(behavior 'require-key
  (let ((*api-key* nil))
    (handler-case (require-key)
      (needs-key (condition)
        (should-be-true (search "MASSIVE_API_KEY" (api-error-message condition))))
      (:no-error (&rest ignored)
        (declare (ignore ignored))
        (should-be-true nil)))))

;;;; -- HTTP ------------------------------------------------------------------

(defun absolute-url-p (value)
  (and (stringp value)
       (> (length value) 8)
       (or (string= (subseq value 0 8) "https://")
           (string= (subseq value 0 7) "http://"))))

(defun default-port-p (scheme port)
  (or (null port)
      (and (member scheme '(:https "https") :test #'equal) (= port 443))
      (and (member scheme '(:http "http") :test #'equal) (= port 80))))

(defun normalize-next-url (url)
  "Absolute URL on the *API* host, with any apiKey query parameter removed.
Massive next_url values are absolute and do not include the key.  The key
stays in the Authorization header."
  (let* ((uri (if (stringp url) (quri:uri url) url))
         (base (quri:uri *api*))
         (params (remove "apiKey"
                         (quri:uri-query-params uri)
                         :key #'car
                         :test #'string-equal))
         (scheme (or (quri:uri-scheme base) :https))
         (port (quri:uri-port base))
         (args (list :scheme scheme
                     :host (quri:uri-host base)
                     :path (quri:uri-path uri))))
    (when params
      (setf args (append args (list :query params))))
    (unless (default-port-p scheme port)
      (setf args (append args (list :port port))))
    (quri:render-uri (apply #'quri:make-uri args))))

(defun request-url (path &rest query-pairs)
  "Absolute URL for PATH and QUERY-PAIRS.  The API key is not included."
  (let ((query (apply #'query query-pairs)))
    (if query
        (quri:render-uri
         (quri:make-uri :defaults (concatenate 'string *api* path)
                        :query (query-alist query)))
        (concatenate 'string *api* path))))

(defun make-request-uri (path-or-url &optional query-args)
  (cond ((absolute-url-p path-or-url)
         (normalize-next-url path-or-url))
        (query-args
         (quri:render-uri
          (quri:make-uri :defaults (concatenate 'string *api* path-or-url)
                         :query (query-alist query-args))))
        (t (concatenate 'string *api* path-or-url))))

(defun request-headers ()
  (list (cons "Accept" "application/json")
        (cons "User-Agent" *user-agent*)))

(defun cache-tag ()
  "Short partition for the response cache.  Not the API key."
  (if (usable-key-p *api-key*)
      (format nil "~8,'0X" (ldb (byte 32 0) (sxhash *api-key*)))
      "none"))

(defun http-get (path-or-url &key (query-args '()))
  "HTTP GET against Massive.  Returns the body and the request URL.
The key is a bearer token.  Redirects are not followed.  HTTP 429 is retried.
Other HTTP errors signal an API-ERROR subclass."
  (require-key)
  (let ((uri (make-request-uri path-or-url query-args))
        (attempts (max 1 *max-retries*)))
    (values
     (loop for attempt from 1 to attempts
           do (handler-case
                  (return (dex:get uri
                                   :headers (request-headers)
                                   :bearer-auth *api-key*
                                   :max-redirects 0
                                   :connect-timeout *request-timeout-seconds*
                                   :read-timeout *request-timeout-seconds*))
                (error (condition)
                  (let ((status (http-status condition)))
                    (cond ((null status)
                           (error condition))
                          (t
                           (let* ((body (http-body condition))
                                  (message (nth-value 0 (error-fields (ensure-text body)))))
                             (if (and (eq (classify-error status nil message)
                                          'rate-limited)
                                      (< attempt attempts))
                                 (sleep (or (retry-after-seconds condition)
                                            (* *retry-wait-seconds* attempt)))
                                 (error (api-error-from status body uri))))))))))
     uri)))

(defun interpret-payload (payload url)
  (let ((failure (payload-failure payload)))
    (when failure
      (error (api-error-from nil payload url))))
  payload)

(defun http-get-json (path-or-url &key (query-args '()))
  "GET and parse JSON.  Arrays become vectors.  Booleans become T and NIL.
A 200 body whose status is not OK or DELAYED is an API-ERROR."
  (multiple-value-bind (body uri) (http-get path-or-url :query-args query-args)
    (let ((text (ensure-text body)))
      (interpret-payload
       (handler-case (parse-json text)
         (error ()
           (error 'api-error
                  :url (uri-string uri)
                  :error-message "Response was not JSON."
                  :body text)))
       (uri-string uri)))))

(function-cache:defcached
    (http-get-json-cached :timeout *api-cache-timeout-seconds*)
    (path-or-url query-args cache-tag)
  (declare (ignore cache-tag))
  (http-get-json path-or-url :query-args query-args))

(sigma/control:function-alias 'http-get-json 'http-get-json-do-not-cache)

(defun fetch-json-url (url &key (cache t))
  (let ((normalized (normalize-next-url url)))
    (if cache
        (http-get-json-cached normalized nil (cache-tag))
        (http-get-json normalized))))

(defun follow-pages (payload &key (max-pages *max-pages*) (cache t))
  "Append next_url pages onto a copy of PAYLOAD, up to MAX-PAGES total.
A repeated cursor stops the walk.  A remaining next_url means the walk
stopped early."
  (unless (hash-table-p payload)
    (return-from follow-pages payload))
  (let ((merged (copy-json-table payload))
        (seen (make-hash-table :test #'equal))
        (pages 1))
    (loop for url = (next-url merged)
          while (and url (< pages max-pages) (not (gethash url seen)))
          do (setf (gethash url seen) t
                   merged (append-page merged (fetch-json-url url :cache cache))
                   pages (1+ pages)))
    merged))

(defun api-get (path &key query (cache t) follow (max-pages *max-pages*))
  "GET PATH with QUERY pairs from QUERY.
CACHE uses the 60-second layer, partitioned so one key's body is not
reused for another.  FOLLOW walks next_url."
  (let ((payload (if cache
                     (http-get-json-cached path query (cache-tag))
                     (http-get-json path :query-args query))))
    (if follow
        (follow-pages payload :max-pages max-pages :cache cache)
        payload)))

(behavior 'cache-tag
  (let ((*api-key* "abc_one"))
    (let ((tag (cache-tag)))
      (should-be-true (stringp tag))
      (should-not-string= "abc_one" tag)
      (let ((*api-key* "abc_two"))
        (should-not-string= tag (cache-tag)))))
  (let ((*api-key* nil))
    (should-string= "none" (cache-tag))))

(behavior 'normalize-next-url
  (let ((*api* "https://api.staging.massive.com"))
    (should-string=
     "https://api.staging.massive.com/v3/reference/tickers?cursor=abc&limit=1"
     (normalize-next-url
      "https://api.massive.com/v3/reference/tickers?cursor=abc&apiKey=SECRET&limit=1")))
  (let ((*api* "https://api.massive.com"))
    (should-string= "https://api.massive.com/v3/reference/tickers/AAPL"
                    (request-url "/v3/reference/tickers/AAPL"))
    (should-be-true
     (search "ticker=AAPL"
             (request-url "/v3/reference/dividends" "ticker" "AAPL" "limit" nil)))))

(behavior 'request-url-has-no-key
  (let ((*api-key* "abc_secret"))
    (should-be-false (search "abc_secret" (request-url "/v1/marketstatus/now")))
    (should-be-false
     (search "apiKey" (request-url "/v3/reference/tickers" "limit" 1)))))

(reload-local-configuration)
(configure-from-environment)
