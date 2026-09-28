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

(uiop:define-package #:massive
  (:use #:common-lisp #:sigma/behave #:massive/rest-api #:massive/flat-files)
  (:reexport #:massive/rest-api #:massive/flat-files)
  (:export #:parse-interval
           #:futures-resolution
           #:asset-class
           #:canonicalize-tickers
           #:ohlc-bar
           #:ohlc-bar-p
           #:ohlc-bar-time
           #:ohlc-bar-open
           #:ohlc-bar-high
           #:ohlc-bar-low
           #:ohlc-bar-close
           #:ohlc-bar-volume
           #:ohlc-bar-adjusted-close
           #:make-ohlc-bar
           #:ohlc-bar-tuple
           #:ohlc-bars-for-ingest
           #:results->bars
           #:price
           #:ohlc-history
           #:ohlc-history-many
           #:flat-ohlc-history
           #:*history-max-pages*
           #:market-status
           #:market-holidays
           #:dividends
           #:splits
           #:version-string
           #:version-list
           #:version-major
           #:version-minor
           #:version-revision)
  (:import-from #:massive/system
                #:version-string
                #:version-list
                #:version-major
                #:version-minor
                #:version-revision))
(in-package #:massive)

(defvar *history-max-pages* 20
  "Page cap for OHLC-HISTORY when :FOLLOW is true.  The first page counts.")

(defun parse-interval (interval)
  "Return (MULTIPLIER . TIMESPAN) from a candlestick interval.
\"5m\", :m, \"1d\", \"1wk\", the string \"M\" (month), and \"session\" work.
The keyword :M is minute, because :M and :m are the same symbol."
  (when interval
    (let* ((raw (cond ((stringp interval) interval)
                      ((symbolp interval) (symbol-name interval))
                      (t (princ-to-string interval))))
           (s (string-downcase raw)))
      (cond ((and (stringp interval) (string= interval "M"))
             (cons 1 "month"))
            ((member s '("m" "min" "minute" "1m") :test #'string=)
             (cons 1 "minute"))
            ((member s '("mo" "month" "monthly" "1mo") :test #'string=)
             (cons 1 "month"))
            ((member s '("h" "hr" "hour" "hours" "hourly" "1h") :test #'string=)
             (cons 1 "hour"))
            ((member s '("d" "day" "days" "daily" "1d") :test #'string=)
             (cons 1 "day"))
            ((member s '("w" "wk" "week" "weeks" "weekly" "1wk") :test #'string=)
             (cons 1 "week"))
            ((member s '("s" "sec" "second" "1s") :test #'string=)
             (cons 1 "second"))
            ((member s '("q" "quarter" "1q") :test #'string=)
             (cons 1 "quarter"))
            ((member s '("y" "yr" "year" "yearly" "1y") :test #'string=)
             (cons 1 "year"))
            ((member s '("session" "1session") :test #'string=)
             (cons 1 "session"))
            (t
             (let ((n nil)
                   (unit s))
               (loop for i from 0 below (length s)
                     while (digit-char-p (char s i))
                     finally (when (plusp i)
                               (setf n (parse-integer s :end i)
                                     unit (subseq s i))))
               (cons (or n 1)
                     (canonicalize-timespan
                      (cond ((member unit '("m" "min") :test #'string=) "minute")
                            ((member unit '("s" "sec") :test #'string=) "second")
                            ((member unit '("h" "hr" "hour") :test #'string=) "hour")
                            ((member unit '("d" "day") :test #'string=) "day")
                            ((member unit '("w" "wk" "week") :test #'string=) "week")
                            ((member unit '("mo" "month") :test #'string=) "month")
                            (t unit))))))))))

(defun futures-resolution (multiplier timespan)
  "Futures candle size, such as \"1day\" or \"5min\"."
  (format nil "~A~A"
          (or multiplier 1)
          (cond ((equal timespan "second") "sec")
                ((equal timespan "minute") "min")
                ((equal timespan "hour") "hour")
                ((equal timespan "day") "day")
                ((equal timespan "week") "week")
                ((equal timespan "month") "month")
                ((equal timespan "quarter") "quarter")
                ((equal timespan "year") "year")
                ((equal timespan "session") "session")
                (t timespan))))

(defun canonicalize-asset (asset)
  (when asset
    (let ((s (string-downcase
              (if (symbolp asset) (symbol-name asset) (string asset)))))
      (cond ((member s '("stock" "stocks" "equity" "equities") :test #'string=)
             :stocks)
            ((member s '("crypto" "cryptocurrency") :test #'string=) :crypto)
            ((member s '("fx" "forex" "currency") :test #'string=) :forex)
            ((member s '("option" "options") :test #'string=) :options)
            ((member s '("index" "indices") :test #'string=) :indices)
            ((member s '("future" "futures") :test #'string=) :futures)
            (t (error "Unknown Massive asset class ~S." asset))))))

(defun asset-class (ticker &optional asset)
  "Asset class for TICKER.  ASSET wins when given.
X: is crypto, C: is forex, I: is an index, O: is an option.
Anything else is a stock.  Futures have no prefix; pass :FUTURES."
  (or (canonicalize-asset asset)
      (let ((symbol (canonicalize-ticker ticker)))
        (if (and symbol (>= (length symbol) 2) (char= (char symbol 1) #\:))
            (case (char symbol 0)
              (#\X :crypto)
              (#\C :forex)
              (#\I :indices)
              (#\O :options)
              (t :stocks))
            :stocks))))

(defun split-comma (string)
  (loop for start = 0 then (1+ end)
        for end = (position #\, string :start start)
        for piece = (string-trim '(#\Space #\Tab) (subseq string start end))
        unless (zerop (length piece))
          collect piece
        while end))

(defun canonicalize-tickers (symbols)
  "A ticker, a comma-separated string, or a list, as a list of uppercase tickers."
  (cond ((null symbols) nil)
        ((stringp symbols)
         (mapcar #'canonicalize-ticker (split-comma symbols)))
        ((symbolp symbols)
         (list (canonicalize-ticker symbols)))
        ((listp symbols)
         (mapcan #'canonicalize-tickers symbols))
        (t (list (canonicalize-ticker symbols)))))

(behavior 'parse-interval
  (should-equal '(5 . "minute") (parse-interval "5m"))
  (should-equal '(1 . "day") (parse-interval :d))
  (should-equal '(1 . "month") (parse-interval "M"))
  (should-equal '(1 . "minute") (parse-interval :m))
  (should-equal '(1 . "minute") (parse-interval "m"))
  (should-equal '(1 . "week") (parse-interval "1wk"))
  (should-equal '(1 . "session") (parse-interval "session"))
  (should-equal '(15 . "minute") (parse-interval "15min"))
  (should-string= "5min" (futures-resolution 5 "minute"))
  (should-string= "1day" (futures-resolution 1 "day")))

(behavior 'asset-class
  (should-eq :stocks (asset-class "aapl"))
  (should-eq :crypto (asset-class "x:btcusd"))
  (should-eq :forex (asset-class "C:EURUSD"))
  (should-eq :indices (asset-class "I:SPX"))
  (should-eq :options (asset-class "O:AAPL230616C00150000"))
  (should-eq :futures (asset-class "ESZ6" :futures))
  (should-eq :stocks (asset-class "C:EURUSD" :stocks))
  (should-equal '("AAPL" "MSFT") (canonicalize-tickers "aapl, msft")))

;;;; -- Bars ------------------------------------------------------------------

(defclass ohlc-bar ()
  ((time
    :initarg :time
    :accessor ohlc-bar-time
    :documentation "Universal time of the bar open.")
   (open
    :initarg :open
    :accessor ohlc-bar-open)
   (high
    :initarg :high
    :accessor ohlc-bar-high)
   (low
    :initarg :low
    :accessor ohlc-bar-low)
   (close
    :initarg :close
    :accessor ohlc-bar-close)
   (volume
    :initarg :volume
    :accessor ohlc-bar-volume
    :initform nil)
   (adjusted-close
    :initarg :adjusted-close
    :accessor ohlc-bar-adjusted-close
    :initform nil
    :documentation "Close of an adjusted REST aggregate, a futures settlement
when the payload has one, or the flat-file close.  NIL when the REST
aggregate was requested unadjusted."))
  (:documentation
   "One Massive OHLC bar.  This is not a CANDLESTICKS:CANDLESTICK.
Use OHLC-BARS-FOR-INGEST to feed candlesticks."))

(defun ohlc-bar-p (object)
  (typep object 'ohlc-bar))

(defun make-ohlc-bar (&key time open high low close volume adjusted-close)
  (make-instance 'ohlc-bar
                 :time time
                 :open open
                 :high high
                 :low low
                 :close close
                 :volume volume
                 :adjusted-close adjusted-close))

(defmethod print-object ((bar ohlc-bar) stream)
  (print-unreadable-object (bar stream :type t)
    (format stream "@ ~A: o~A h~A l~A c~A"
            (ohlc-bar-time bar)
            (ohlc-bar-open bar)
            (ohlc-bar-high bar)
            (ohlc-bar-low bar)
            (ohlc-bar-close bar))))

(defun ohlc-bar-tuple (bar)
  "One ingest row for CANDLESTICKS:INGEST-CANDLESTICKS:
(time open high low close volume adjusted-close)."
  (list (ohlc-bar-time bar)
        (ohlc-bar-open bar)
        (ohlc-bar-high bar)
        (ohlc-bar-low bar)
        (ohlc-bar-close bar)
        (ohlc-bar-volume bar)
        (ohlc-bar-adjusted-close bar)))

(defun ohlc-bars-for-ingest (bars)
  "Translate OHLC-BAR objects into the list of tuples
CANDLESTICKS:INGEST-CANDLESTICKS expects."
  (map 'list #'ohlc-bar-tuple bars))

(defun row-field (row string-key keyword)
  (cond ((hash-table-p row) (gethash string-key row))
        ((listp row) (getf row keyword))
        (t nil)))

(defun aggregate->bar (row &key adjusted)
  "OHLC-BAR from one REST aggregate object or one flat-file row.
A row whose open, high, low, and close are all missing is NIL."
  (let ((open (json-number (or (row-field row "o" :o)
                               (row-field row "open" :open))))
        (high (json-number (or (row-field row "h" :h)
                               (row-field row "high" :high))))
        (low (json-number (or (row-field row "l" :l)
                              (row-field row "low" :low))))
        (close (json-number (or (row-field row "c" :c)
                                (row-field row "close" :close))))
        (volume (json-number (or (row-field row "v" :v)
                                 (row-field row "volume" :volume))))
        (stamp (or (row-field row "t" :t)
                   (row-field row "window_start" :window-start)
                   (row-field row "session_end_date" :session-end-date)))
        (settlement (json-number (row-field row "settlement_price"
                                            :settlement-price))))
    (when (or open high low close)
      (make-ohlc-bar :time (timestamp->universal stamp)
                     :open open
                     :high high
                     :low low
                     :close close
                     :volume volume
                     :adjusted-close (or settlement (and adjusted close))))))

(defun results->bars (payload)
  "OHLC-BAR list from an aggregates payload.  Blank OHLC rows are dropped.
ADJUSTED-CLOSE is the close when the payload says adjusted is true."
  (let ((adjusted (and (hash-table-p payload)
                       (json-true-p (gethash "adjusted" payload)))))
    (remove nil
            (mapcar (lambda (row) (aggregate->bar row :adjusted adjusted))
                    (json-list (and (hash-table-p payload)
                                    (gethash "results" payload)))))))

(defun aggregates-meta (payload &key ticker asset multiplier timespan from to endpoint)
  (list :ticker (or (and (hash-table-p payload) (gethash "ticker" payload))
                    (canonicalize-ticker ticker))
        :asset asset
        :adjusted (and (hash-table-p payload)
                       (json-true-p (gethash "adjusted" payload)))
        :multiplier multiplier
        :timespan timespan
        :from from
        :to to
        :results-count (and (hash-table-p payload)
                            (or (gethash "resultsCount" payload)
                                (gethash "count" payload)))
        :status (and (hash-table-p payload) (gethash "status" payload))
        :truncated (and (next-url payload) t)
        :next-url (next-url payload)
        :endpoint endpoint))

(behavior 'results->bars
  (let* ((payload (let ((yason:*parse-json-arrays-as-vectors* t)
                        (yason:*parse-json-booleans-as-symbols* t))
                    (yason:parse "{\"ticker\":\"AAPL\",\"adjusted\":true,\"status\":\"OK\",\"resultsCount\":2,\"results\":[{\"o\":10,\"h\":12,\"l\":9,\"c\":11,\"v\":100,\"t\":1700000000000},{\"o\":null,\"h\":null,\"l\":null,\"c\":null,\"t\":1700086400000}]}")))
         (bars (results->bars payload)))
    (should= 1 (length bars))
    (should-be-true (ohlc-bar-p (first bars)))
    (should= (unix->universal 1700000000) (ohlc-bar-time (first bars)))
    (should= 10 (ohlc-bar-open (first bars)))
    (should= 11 (ohlc-bar-close (first bars)))
    (should= 11 (ohlc-bar-adjusted-close (first bars)))
    (should= 100 (ohlc-bar-volume (first bars)))
    (should= 7 (length (ohlc-bar-tuple (first bars))))
    (should-equal (ohlc-bar-tuple (first bars))
                  (first (ohlc-bars-for-ingest bars)))))

(behavior 'aggregate-row-flat-file
  (let ((bar (aggregate->bar
              '(:ticker "AAPL" :open 10 :high 12 :low 9 :close 11
                :volume 100 :window-start 1700000000000000000)
              :adjusted t)))
    (should= 11 (ohlc-bar-close bar))
    (should= 11 (ohlc-bar-adjusted-close bar))
    (should= (unix->universal 1700000000) (ohlc-bar-time bar))))

;;;; -- REST history ----------------------------------------------------------

(defun adjusted-flag (adjusted)
  "T or :FALSE.  NIL means false, because the REST default is adjusted."
  (if adjusted t :false))

(defun maybe-follow (payload follow max-pages)
  (if (and follow (next-url payload))
      (follow-pages payload :max-pages max-pages :cache nil)
      payload))

(defun previous-payload (ticker asset adjusted cache)
  (let ((flag (adjusted-flag adjusted)))
    (ecase asset
      (:stocks (get-previous-stocks-aggregates ticker :adjusted flag :cache cache))
      (:crypto (get-previous-crypto-aggregates ticker :adjusted flag :cache cache))
      (:forex (get-previous-forex-aggregates ticker :adjusted flag :cache cache))
      (:options (get-previous-options-aggregates ticker :adjusted flag :cache cache))
      (:indices (get-previous-indices-aggregates ticker :cache cache)))))

(defun previous-endpoint (ticker asset adjusted)
  (let ((path (format nil "/v2/aggs/ticker/~A/prev" (ticker-segment ticker))))
    (if (eq asset :indices)
        (request-url path)
        (request-url path "adjusted" (adjusted-flag adjusted)))))

(defun range-payload (ticker asset multiplier timespan from to
                      adjusted sort limit follow max-pages cache)
  (let ((flag (adjusted-flag adjusted)))
    (ecase asset
      (:stocks
       (get-stocks-aggregates ticker multiplier timespan from to
                              :adjusted flag :sort sort :limit limit
                              :follow follow :max-pages max-pages :cache cache))
      (:crypto
       (maybe-follow
        (get-crypto-aggregates ticker multiplier timespan from to
                               :adjusted flag :sort sort :limit limit :cache cache)
        follow max-pages))
      (:forex
       (maybe-follow
        (get-forex-aggregates ticker multiplier timespan from to
                              :adjusted flag :sort sort :limit limit :cache cache)
        follow max-pages))
      (:options
       (maybe-follow
        (get-options-aggregates ticker multiplier timespan from to
                                :adjusted flag :sort sort :limit limit :cache cache)
        follow max-pages))
      (:indices
       (maybe-follow
        (get-indices-aggregates ticker multiplier timespan from to
                                :sort sort :limit limit :cache cache)
        follow max-pages)))))

(defun range-endpoint (ticker asset multiplier timespan from to adjusted sort)
  (let ((path (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                      (ticker-segment ticker)
                      (path-segment multiplier)
                      (timespan-segment timespan)
                      (path-segment from)
                      (path-segment to))))
    (if (eq asset :indices)
        (request-url path "sort" sort)
        (request-url path "adjusted" (adjusted-flag adjusted) "sort" sort))))

(defun futures-payload (ticker resolution from to sort limit follow max-pages cache)
  (get-futures-aggregates ticker
                          :resolution resolution
                          :window-start.gte from
                          :window-start.lte to
                          :sort sort
                          :limit limit
                          :follow follow
                          :max-pages max-pages
                          :cache cache))

(defun ohlc-history (ticker &key (multiplier 1) (timespan :day) interval
                            from to (adjusted t) (sort :asc) limit
                            (follow t) (max-pages *history-max-pages*)
                            (cache nil) asset)
  "OHLC-BAR list for TICKER.

The second value is a meta plist: :ticker, :asset, :adjusted, :multiplier,
:timespan, :from, :to, :results-count, :truncated, :next-url, :endpoint.

With no :FROM or :TO, a 1-day request is the previous trading day's bar.
That is the aggregate the free plan includes.  Any other window uses the
range endpoint, which the free plan rejects with PLAN-RESTRICTED.
Intraday bars require :FROM and :TO.

:INTERVAL (\"5m\", :d, \"1wk\") overrides :MULTIPLIER and :TIMESPAN.
:ASSET :FUTURES selects /futures/v1/aggs.  Futures prefixes are not inferred.
X:, C:, I:, and O: select crypto, forex, indices, and options.

:FOLLOW walks next_url up to :MAX-PAGES.  :TRUNCATED in the meta plist
means a cursor remained.  This library does not depend on candlesticks.
Pass the bars through OHLC-BARS-FOR-INGEST before INGEST-CANDLESTICKS."
  (let* ((ticker (canonicalize-ticker ticker))
         (parsed (if interval
                     (parse-interval interval)
                     (cons multiplier (canonicalize-timespan timespan))))
         (mult (car parsed))
         (span (cdr parsed))
         (asset (asset-class ticker asset))
         (unit (if (eq asset :futures) :ns :ms))
         (from-s (canonicalize-window from :unit unit))
         (to-s (canonicalize-window to :unit unit)))
    (cond ((eq asset :futures)
           (let* ((bounded (or from-s to-s))
                  (resolution (futures-resolution mult span))
                  (sort-value (if bounded "window_start.asc" "window_start.desc"))
                  (payload (futures-payload ticker resolution from-s to-s
                                            sort-value
                                            (or limit (if bounded nil 1))
                                            (and bounded follow)
                                            max-pages cache))
                  (bars (results->bars payload)))
             (values (if bounded bars (nreverse bars))
                     (aggregates-meta
                      payload
                      :ticker ticker :asset asset
                      :multiplier mult :timespan span
                      :from from-s :to to-s
                      :endpoint (request-url
                                 (format nil "/futures/v1/aggs/~A"
                                         (ticker-segment ticker))
                                 "resolution" resolution
                                 "window_start.gte" from-s
                                 "window_start.lte" to-s
                                 "sort" sort-value)))))
          ((and (null from-s) (null to-s) (eql mult 1) (equal span "day") (null limit))
           (let ((payload (previous-payload ticker asset adjusted cache)))
             (values (results->bars payload)
                     (aggregates-meta payload
                                      :ticker ticker :asset asset
                                      :multiplier 1 :timespan "day"
                                      :endpoint (previous-endpoint ticker asset adjusted)))))
          ((and (null from-s) (null to-s))
           (error "OHLC-HISTORY needs :FROM and :TO for ~A ~A bars of ~A."
                  mult span ticker))
          (t
           (let ((payload (range-payload ticker asset mult span from-s to-s
                                         adjusted sort limit follow max-pages cache)))
             (values (results->bars payload)
                     (aggregates-meta payload
                                      :ticker ticker :asset asset
                                      :multiplier mult :timespan span
                                      :from from-s :to to-s
                                      :endpoint (range-endpoint ticker asset mult span
                                                                from-s to-s adjusted sort))))))))

(defun price (ticker &key (adjusted t) asset (cache nil))
  "Previous trading day's close, or the latest futures bar when ASSET is :FUTURES.
The second value is the OHLC-BAR.  The third is the meta plist.
A missing bar is NIL, not zero."
  (multiple-value-bind (bars meta)
      (ohlc-history ticker :adjusted adjusted :asset asset :cache cache)
    (values (when bars (ohlc-bar-close (first bars)))
            (first bars)
            meta)))

(defun drop-keys (plist &rest keys)
  (loop for (key value) on plist by #'cddr
        unless (member key keys)
          append (list key value)))

(defun ohlc-history-many (symbols &rest args &key (continue-on-error t) &allow-other-keys)
  "OHLC-HISTORY for each ticker in SYMBOLS, with the same keyword arguments.

SYMBOLS is a ticker, a comma-separated string, or a list.  Each success
is (:symbol :bars :meta).  When CONTINUE-ON-ERROR is true, a per-ticker
failure is (:symbol :error) instead of aborting the batch.  RATE-LIMITED
always aborts the batch, so a free-plan cap does not turn into more calls."
  (let ((tickers (canonicalize-tickers symbols))
        (call (drop-keys args :continue-on-error)))
    (unless tickers
      (return-from ohlc-history-many nil))
    (loop for ticker in tickers
          collect (handler-case
                      (multiple-value-bind (bars meta)
                          (apply #'ohlc-history ticker call)
                        (list :symbol ticker :bars bars :meta meta))
                    (rate-limited (condition)
                      (error condition))
                    (error (condition)
                      (unless continue-on-error
                        (error condition))
                      (list :symbol ticker :error condition))))))

(behavior 'ohlc-history-many-empty
  (should-be-null (ohlc-history-many nil))
  (should-be-null (ohlc-history-many "")))

;;;; -- Flat-file history -----------------------------------------------------

(defun resolve-flat-dataset (dataset exchange)
  (cond ((flat-dataset-p dataset) dataset)
        ((and exchange
              (member dataset '(:minute :session :trades :quotes :day)
                      :test #'eq))
         (futures-dataset exchange dataset))
        (t (flat-dataset dataset))))

(defun flat-ohlc-history (ticker &key (dataset :stocks-day) from to exchange
                                 (skip-weekends :auto) (skip-missing t))
  "OHLC bars for TICKER from flat files, one gzip per day.

The second value is a meta plist: :dataset, :prefix, :from, :to, :files,
:skipped, :endpoint.  :FILES is how many objects were read.  :SKIPPED is
how many dates had no object.

FROM and TO are inclusive.  Stocks, options, indices, and futures skip
Saturday and Sunday unless :SKIP-WEEKENDS is NIL.  A missing object is
skipped when SKIP-MISSING is true.  PLAN-RESTRICTED stops the walk.
The free Stocks Basic plan does not include flat files.

Each file is the whole market for that day.  Other tickers are discarded
while the file is read; the download is still the whole file.  Minute,
quote, and trade files are large.  DATASET :STOCKS-MINUTE is one minute
file per day, not a REST range.

DATASET is :STOCKS-DAY, :STOCKS-MINUTE, :OPTIONS-DAY, :CRYPTO-DAY, and
the other names from FLAT-DATASETS.  Futures are :MINUTE, :SESSION,
:TRADES, or :QUOTES plus :EXCHANGE :CME, :CBOT, :NYMEX, or :COMEX.
Trades, quotes, and index values are not bars; use MAP-FLAT-FILE.

ADJUSTED-CLOSE is the file's close.  The file has no separate adjustment
column.  This library does not depend on candlesticks."
  (let* ((ds (resolve-flat-dataset dataset exchange))
         (ticker (canonicalize-ticker ticker))
         (skip (if (eq skip-weekends :auto)
                   (dataset-skip-weekends-p ds)
                   skip-weekends)))
    (unless (member (flat-dataset-kind ds) '(:day :minute :session))
      (error "FLAT-OHLC-HISTORY reads aggregate files. ~A is a ~A file. Use MAP-FLAT-FILE."
             (flat-dataset-name ds) (flat-dataset-kind ds)))
    (unless (and from to)
      (error "FLAT-OHLC-HISTORY needs :FROM and :TO."))
    (let ((dates (date-range from to :skip-weekends skip))
          (bars '())
          (files 0)
          (skipped 0))
      (dolist (date dates)
        (handler-case
            (progn
              (map-flat-file ds date
                             (lambda (row)
                               (let ((bar (aggregate->bar row :adjusted t)))
                                 (when bar (push bar bars))))
                             :ticker ticker)
              (incf files))
          (not-found (condition)
            (if skip-missing
                (incf skipped)
                (error condition)))))
      (values (nreverse bars)
              (list :ticker ticker
                    :dataset (flat-dataset-name ds)
                    :prefix (flat-dataset-prefix ds)
                    :asset (flat-dataset-asset ds)
                    :from (first dates)
                    :to (car (last dates))
                    :files files
                    :skipped skipped
                    :endpoint (concatenate 'string
                                           (string-right-trim "/" *s3-endpoint*)
                                           "/" *s3-bucket* "/"
                                           (flat-dataset-prefix ds)))))))

(sigma/control:function-alias 'get-market-status 'market-status)
(sigma/control:function-alias 'get-market-holidays 'market-holidays)
(sigma/control:function-alias 'list-dividends 'dividends)
(sigma/control:function-alias 'list-stock-splits 'splits)
