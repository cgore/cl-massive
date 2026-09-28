# cl-massive

A Common Lisp client for [Massive](https://massive.com) (formerly Polygon.io).
This is not an official Massive library.

It covers the REST surface in the OpenAPI spec: stocks, options, indices,
forex, crypto, futures, economy, filings, financials, and the partner
datasets.  It also reads [flat files](https://massive.com/docs/flat-files/quickstart),
the daily gzip CSVs on Massive's S3 endpoint, which is the way to load a
lot of history without walking the REST page cap.  WebSockets are not
wrapped.

- Docs: [massive.com/docs](https://massive.com/docs)
- REST catalog: [documentation/endpoints.md](documentation/endpoints.md)
- API origin: `https://api.massive.com`
- Flat files: `https://files.massive.com`, bucket `flatfiles`
- Github: [cgore/cl-massive](https://github.com/cgore/cl-massive)

## Install

Clone next to your other local systems (or symlink the `.asd` into
`~/programming/lisp/systems/`):

```lisp
(asdf:load-system :massive)
(in-package :massive)
```

Depends on `babel`, `chipz`, `dexador`, `flexi-streams`, `function-cache`,
`ironclad`, `quri`, `sigma`, and `yason`.

## Authentication

REST calls send the key as `Authorization: Bearer`.  It is not put on the
query string, so it does not land in `next_url` or in the URLs this client
builds.

On load the library looks for a gitignored Lisp file:

```
source/configuration/local-configuration.lisp
```

That file is loaded in the `massive/rest-api` package.  It can rebind
`*api-key*` and the flat-file parameters:

```lisp
(defparameter *api-key* "your_rest_key")

;; Flat files use a different pair, from the same dashboard page.
(defparameter *s3-access-key* "your_s3_access_key")
(defparameter *s3-secret-key* "your_s3_secret_key")
```

When that file is missing, or it does not leave a usable REST key, the
library reads `MASSIVE_API_KEY`.  S3 keys are read from
`MASSIVE_S3_ACCESS_KEY` and `MASSIVE_S3_SECRET_ACCESS_KEY` (the
`MASSIVE_FILES_*` names work too).  A key already set from the local file
wins.  You can also set them in the image:

```lisp
(use-key "your_rest_key")
(reload-local-configuration)
```

Create keys at [massive.com/dashboard/keys](https://massive.com/dashboard/keys).
Do not commit a real key.  The local configuration file is gitignored.

A 401 is `unauthorized`.  A 403, or a body whose status is `NOT_AUTHORIZED`,
is `plan-restricted`.  A 404 is `not-found`.  A 429 is `rate-limited`, which
this client retries.  The free plan's cap is small; `*max-retries*` and
`*retry-wait-seconds*` control that sleep.

On the free plan, previous-day aggregates, ticker reference, dividends,
market status, and treasury yields answered.  Historical aggregate ranges,
open/close, snapshots, quotes, and trades came back `plan-restricted`.
The wrappers are still there for when the plan includes them.  Flat files
are not part of Stocks Basic.

## A price and a bar

```lisp
(price "AAPL")
(nth-value 1 *)   ; the OHLC-BAR
(nth-value 2 *)   ; meta plist: ticker, asset, endpoint, ...

(ohlc-history "AAPL")                 ; previous daily bar
(ohlc-history :msft :adjusted nil)    ; :FALSE is sent; the REST default is adjusted
(ohlc-history "X:BTCUSD")             ; crypto, from the X: prefix
(ohlc-history "C:EURUSD")
(ohlc-history "I:SPX")
```

`price` is the previous close.  An empty bar is `nil`, not zero.

`ohlc-history` returns `ohlc-bar` objects and a meta plist.  With no
`:from` or `:to`, a daily request uses `/prev`.  A window uses the range
endpoint.  `:interval` accepts `"5m"`, `:d`, `"1wk"`, and the string `"M"`
for month.  The keyword `:m` is minute.

```lisp
(ohlc-history "AAPL"
              :from "2024-01-02"
              :to   "2024-02-01"
              :interval "1d")

(multiple-value-bind (bars meta)
    (ohlc-history "AAPL" :interval "5m"
                  :from "2024-01-02" :to "2024-01-03")
  (list (length bars)
        (getf meta :truncated)     ; T when a next_url remained
        (getf meta :endpoint)))
```

`:follow` walks `next_url` up to `*history-max-pages*` (20).  The first
page counts.  `:truncated` in the meta plist means the walk stopped early.

`ohlc-history-many` runs one window across several tickers.  A
`rate-limited` error aborts the batch instead of issuing more calls.

```lisp
(ohlc-history-many '("AAPL" "MSFT") :from "2024-01-02" :to "2024-01-05")
```

## Feeding candlesticks

This library does **not** depend on
[candlesticks](https://github.com/cgore/candlesticks).  An application
can load both:

```lisp
(ql:quickload '(:massive :candlesticks))

(multiple-value-bind (bars meta)
    (massive:ohlc-history "AAPL" :from "2024-01-02" :to "2024-06-28")
  (candlesticks:ingest-candlesticks
   "AAPL" "USD" "d"
   (massive:ohlc-bars-for-ingest bars)
   :source-name "Massive"
   :source-kind "api"
   :endpoint (getf meta :endpoint)
   :numerator-name "Apple"
   :numerator-type "stock"
   :denominator-name "US Dollar"
   :denominator-type "currency"))
```

When the REST aggregate was adjusted, `adjusted-close` is that close.
An unadjusted request leaves `adjusted-close` nil.  Flat-file bars put
the file's close in `adjusted-close`; the CSV has no separate adjustment
column.

## Flat files

Flat files are gzip CSV, one object per market per day, on an
S3-compatible endpoint:

- Endpoint: `https://files.massive.com`
- Bucket: `flatfiles`
- Credentials: the S3 access key and secret from the dashboard, not the REST key

A day file contains every ticker.  Filtering to AAPL still downloads the
whole object; other rows are dropped while the file is read.  Minute,
quote, and trade files are large.  `map-flat-file` streams them.
`read-flat-file` collects every row, which is the wrong tool for a
minute file.

```lisp
(flat-object-key :stocks-day "2024-03-01")
;; "us_stocks_sip/day_aggs_v1/2024/03/2024-03-01.csv.gz"

(flat-ohlc-history "AAPL"
                   :dataset :stocks-day
                   :from "2024-01-02"
                   :to   "2024-03-01")

(flat-ohlc-history "ESH6"
                   :dataset :minute
                   :exchange :cme
                   :from "2024-03-01"
                   :to   "2024-03-01")
```

`flat-ohlc-history` walks inclusive dates.  Stocks, options, indices, and
futures skip Saturday and Sunday unless you pass `:skip-weekends nil`.
A missing object is skipped.  `plan-restricted` stops the walk.  The
second value says how many files were read and how many dates were missing.

Other datasets are `:stocks-minute`, `:stocks-trades`, `:stocks-quotes`,
`:options-day`, `:indices-values`, `:forex-quotes`, `:crypto-day`, and the
futures names from `flat-datasets`.  Trades, quotes, and index values are
not bars:

```lisp
(map-flat-file :stocks-trades "2024-03-01"
               (lambda (row)
                 (list (getf row :ticker) (getf row :price) (getf row :size)))
               :ticker "AAPL")

(list-flat-files :prefix :stocks-day :delimiter "/")
(download-flat-file :stocks-day "2024-03-01" #P"/tmp/2024-03-01.csv.gz")
```

Files for a trading day show up around 11:00 AM ET the next day.

## The rest of the API

Every REST operation has a function in `massive/rest-api`, re-exported
from `massive`.  The names and paths are listed in
[documentation/endpoints.md](documentation/endpoints.md).  Regenerate
that list from a newer spec with `scripts/generate-endpoints.py`.

Keyword arguments are the query parameters.  Underscores become hyphens.
Dots stay, so the filter is `:date.gte`.  `t` sends `true`, `:false`
sends `false`, and `nil` omits the parameter.  A ticker keyword such as
`:aapl` is uppercased.  Lists become comma-separated.

```lisp
(market-status)
(get-ticker "AAPL")
(dividends :ticker "AAPL" :limit 5)
(list-tickers :market :stocks :active t :limit 10)
(get-fed-v1-treasury-yields :limit 5 :sort "date.desc")
```

Reference reads are cached for `*api-cache-timeout-seconds*` (60).
Aggregates, snapshots, trades, quotes, and market status are not.
Pass `:cache t` or `:cache nil` to override.  The cache is partitioned
by a short hash of the REST key, not by the key itself.

Operations that return `next_url` take `:follow` and `:max-pages`.
`:follow` defaults to nil on those calls.  `ohlc-history` is the one
that follows by default.

## Testing

Specs are `sigma/behave` `behavior` / `should` forms, same style as
[sigma](https://github.com/cgore/sigma).  They run at load time and do
not touch the network.  A checked-in one-day gzip fixture covers the CSV
reader.  The S3 signer is checked against the published AWS example.

```lisp
(asdf:test-system :massive)
```

That reloads the sources and runs the same specs.

One REST call, the previous AAPL bar:

```
MASSIVE_LIVE_TESTS=1
```

One S3 list of the bucket root, and no download:

```
MASSIVE_FLAT_FILE_LIVE_TESTS=1
```

A `rate-limited` or `plan-restricted` response is a skip.  The flat-file
check is also a skip when the S3 keys are not set.

## License

Copyright (c) 2026, Christopher Mark Gore,  
Soli Deo Gloria,  
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of Christopher Mark Gore nor the names of other contributors may be used to endorse or promote products derived from this software without specific prior written permission.

**THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS *"AS IS"* AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.**
