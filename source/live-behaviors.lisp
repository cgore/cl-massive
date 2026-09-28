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

;;;; Optional live checks.  Loaded only by TEST-OP when an environment
;;;; variable is set, so an ordinary load never touches the network.
;;;;
;;;; MASSIVE_LIVE_TESTS=1           one REST call: previous AAPL bar.
;;;; MASSIVE_FLAT_FILE_LIVE_TESTS=1 one S3 list of the bucket root.  No download.

(in-package #:massive)

(when (uiop:getenv "MASSIVE_LIVE_TESTS")
  (behavior 'previous-close-live
    (let ((*max-retries* 1))
      (handler-case
          (multiple-value-bind (bars meta) (ohlc-history "AAPL")
            (should-be-true (= 1 (length bars)))
            (should-string= "AAPL" (getf meta :ticker))
            (should-eq :stocks (getf meta :asset))
            (should-be-true (ohlc-bar-p (first bars)))
            (should-be-a 'number (ohlc-bar-close (first bars)))
            (should-be-true (search "/v2/aggs/ticker/AAPL/prev"
                                    (getf meta :endpoint))))
        (rate-limited () t)
        (plan-restricted () t)))))

(when (uiop:getenv "MASSIVE_FLAT_FILE_LIVE_TESTS")
  (behavior 'list-flat-files-live
    (let ((*max-retries* 1))
      (handler-case
          (let ((page (list-flat-files :prefix "" :delimiter "/" :max-keys 20)))
            (should-be-true (or (getf page :common-prefixes)
                                (getf page :objects))))
        (needs-key () t)
        (rate-limited () t)
        (plan-restricted () t)
        (unauthorized () t)))))
