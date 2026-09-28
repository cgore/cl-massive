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

;;;; Generated from the Massive OpenAPI spec by scripts/generate-endpoints.py.
;;;; One function per REST operation.  Keyword arguments are the query
;;;; parameters (underscores become hyphens; dots stay, so :date.gte is
;;;; date.gte).  T sends true, :FALSE sends false, NIL omits the parameter.
;;;; :FOLLOW walks next_url up to :MAX-PAGES when the operation paginates.

(in-package #:massive/rest-api)

(defun get-benzinga-v1-analyst-insights (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     last-updated
     last-updated.gt
     last-updated.gte
     last-updated.lt
     last-updated.lte
     firm
     firm.any-of
     firm.gt
     firm.gte
     firm.lt
     firm.lte
     rating-action
     rating-action.any-of
     rating-action.gt
     rating-action.gte
     rating-action.lt
     rating-action.lte
     benzinga-firm-id
     benzinga-firm-id.any-of
     benzinga-firm-id.gt
     benzinga-firm-id.gte
     benzinga-firm-id.lt
     benzinga-firm-id.lte
     benzinga-rating-id
     benzinga-rating-id.any-of
     benzinga-rating-id.gt
     benzinga-rating-id.gte
     benzinga-rating-id.lt
     benzinga-rating-id.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/analyst-insights
get_benzinga_v1_analyst-insights. A comprehensive database of financial analyst insights and ratings for various publicly traded companies, capturing detailed information about analyst recommendations and price targets. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/analyst-insights"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "last_updated" last-updated
                         "last_updated.gt" last-updated.gt
                         "last_updated.gte" last-updated.gte
                         "last_updated.lt" last-updated.lt
                         "last_updated.lte" last-updated.lte
                         "firm" firm
                         "firm.any_of" firm.any-of
                         "firm.gt" firm.gt
                         "firm.gte" firm.gte
                         "firm.lt" firm.lt
                         "firm.lte" firm.lte
                         "rating_action" rating-action
                         "rating_action.any_of" rating-action.any-of
                         "rating_action.gt" rating-action.gt
                         "rating_action.gte" rating-action.gte
                         "rating_action.lt" rating-action.lt
                         "rating_action.lte" rating-action.lte
                         "benzinga_firm_id" benzinga-firm-id
                         "benzinga_firm_id.any_of" benzinga-firm-id.any-of
                         "benzinga_firm_id.gt" benzinga-firm-id.gt
                         "benzinga_firm_id.gte" benzinga-firm-id.gte
                         "benzinga_firm_id.lt" benzinga-firm-id.lt
                         "benzinga_firm_id.lte" benzinga-firm-id.lte
                         "benzinga_rating_id" benzinga-rating-id
                         "benzinga_rating_id.any_of" benzinga-rating-id.any-of
                         "benzinga_rating_id.gt" benzinga-rating-id.gt
                         "benzinga_rating_id.gte" benzinga-rating-id.gte
                         "benzinga_rating_id.lt" benzinga-rating-id.lt
                         "benzinga_rating_id.lte" benzinga-rating-id.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-analysts (&key
     benzinga-id
     benzinga-id.any-of
     benzinga-id.gt
     benzinga-id.gte
     benzinga-id.lt
     benzinga-id.lte
     benzinga-firm-id
     benzinga-firm-id.any-of
     benzinga-firm-id.gt
     benzinga-firm-id.gte
     benzinga-firm-id.lt
     benzinga-firm-id.lte
     firm-name
     firm-name.any-of
     firm-name.gt
     firm-name.gte
     firm-name.lt
     firm-name.lte
     full-name
     full-name.any-of
     full-name.gt
     full-name.gte
     full-name.lt
     full-name.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/analysts
get_benzinga_v1_analysts. A comprehensive database of financial analysts, containing detailed performance metrics and identification information for individual analysts across various financial firms. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/analysts"
           :query (query
                         "benzinga_id" benzinga-id
                         "benzinga_id.any_of" benzinga-id.any-of
                         "benzinga_id.gt" benzinga-id.gt
                         "benzinga_id.gte" benzinga-id.gte
                         "benzinga_id.lt" benzinga-id.lt
                         "benzinga_id.lte" benzinga-id.lte
                         "benzinga_firm_id" benzinga-firm-id
                         "benzinga_firm_id.any_of" benzinga-firm-id.any-of
                         "benzinga_firm_id.gt" benzinga-firm-id.gt
                         "benzinga_firm_id.gte" benzinga-firm-id.gte
                         "benzinga_firm_id.lt" benzinga-firm-id.lt
                         "benzinga_firm_id.lte" benzinga-firm-id.lte
                         "firm_name" firm-name
                         "firm_name.any_of" firm-name.any-of
                         "firm_name.gt" firm-name.gt
                         "firm_name.gte" firm-name.gte
                         "firm_name.lt" firm-name.lt
                         "firm_name.lte" firm-name.lte
                         "full_name" full-name
                         "full_name.any_of" full-name.any-of
                         "full_name.gt" full-name.gt
                         "full_name.gte" full-name.gte
                         "full_name.lt" full-name.lt
                         "full_name.lte" full-name.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-bulls-bears-say (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     benzinga-id
     benzinga-id.any-of
     benzinga-id.gt
     benzinga-id.gte
     benzinga-id.lt
     benzinga-id.lte
     last-updated
     last-updated.gt
     last-updated.gte
     last-updated.lt
     last-updated.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/bulls-bears-say
get_benzinga_v1_bulls-bears-say. A comprehensive database of analyst bull and bear case summaries for publicly traded companies, providing concise summaries of both bullish and bearish investment arguments to help investors see both sides of the story before making investment decisions. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/bulls-bears-say"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "benzinga_id" benzinga-id
                         "benzinga_id.any_of" benzinga-id.any-of
                         "benzinga_id.gt" benzinga-id.gt
                         "benzinga_id.gte" benzinga-id.gte
                         "benzinga_id.lt" benzinga-id.lt
                         "benzinga_id.lte" benzinga-id.lte
                         "last_updated" last-updated
                         "last_updated.gt" last-updated.gt
                         "last_updated.gte" last-updated.gte
                         "last_updated.lt" last-updated.lt
                         "last_updated.lte" last-updated.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-consensus-ratings-ticker (ticker
    &key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/consensus-ratings/{ticker}
get_benzinga_v1_consensus-ratings_ticker. A comprehensive financial consensus ratings table that aggregates analyst recommendations and price targets for individual stock tickers, capturing detailed rating breakdowns and statistical insights. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/benzinga/v1/consensus-ratings/~A"
                   (ticker-segment ticker))
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-earnings (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     importance
     importance.any-of
     importance.gt
     importance.gte
     importance.lt
     importance.lte
     last-updated
     last-updated.any-of
     last-updated.gt
     last-updated.gte
     last-updated.lt
     last-updated.lte
     date-status
     date-status.any-of
     date-status.gt
     date-status.gte
     date-status.lt
     date-status.lte
     eps-surprise-percent
     eps-surprise-percent.any-of
     eps-surprise-percent.gt
     eps-surprise-percent.gte
     eps-surprise-percent.lt
     eps-surprise-percent.lte
     revenue-surprise-percent
     revenue-surprise-percent.any-of
     revenue-surprise-percent.gt
     revenue-surprise-percent.gte
     revenue-surprise-percent.lt
     revenue-surprise-percent.lte
     fiscal-year
     fiscal-year.any-of
     fiscal-year.gt
     fiscal-year.gte
     fiscal-year.lt
     fiscal-year.lte
     fiscal-period
     fiscal-period.any-of
     fiscal-period.gt
     fiscal-period.gte
     fiscal-period.lt
     fiscal-period.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/earnings
get_benzinga_v1_earnings. This table contains earnings data from Benzinga, tracking both actual and estimated financial metrics for publicly traded companies. It includes EPS and revenue figures with surprise calculations, along with metadata like fiscal periods, company identifiers, and reporting... Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/earnings"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "importance" importance
                         "importance.any_of" importance.any-of
                         "importance.gt" importance.gt
                         "importance.gte" importance.gte
                         "importance.lt" importance.lt
                         "importance.lte" importance.lte
                         "last_updated" last-updated
                         "last_updated.any_of" last-updated.any-of
                         "last_updated.gt" last-updated.gt
                         "last_updated.gte" last-updated.gte
                         "last_updated.lt" last-updated.lt
                         "last_updated.lte" last-updated.lte
                         "date_status" date-status
                         "date_status.any_of" date-status.any-of
                         "date_status.gt" date-status.gt
                         "date_status.gte" date-status.gte
                         "date_status.lt" date-status.lt
                         "date_status.lte" date-status.lte
                         "eps_surprise_percent" eps-surprise-percent
                         "eps_surprise_percent.any_of" eps-surprise-percent.any-of
                         "eps_surprise_percent.gt" eps-surprise-percent.gt
                         "eps_surprise_percent.gte" eps-surprise-percent.gte
                         "eps_surprise_percent.lt" eps-surprise-percent.lt
                         "eps_surprise_percent.lte" eps-surprise-percent.lte
                         "revenue_surprise_percent" revenue-surprise-percent
                         "revenue_surprise_percent.any_of" revenue-surprise-percent.any-of
                         "revenue_surprise_percent.gt" revenue-surprise-percent.gt
                         "revenue_surprise_percent.gte" revenue-surprise-percent.gte
                         "revenue_surprise_percent.lt" revenue-surprise-percent.lt
                         "revenue_surprise_percent.lte" revenue-surprise-percent.lte
                         "fiscal_year" fiscal-year
                         "fiscal_year.any_of" fiscal-year.any-of
                         "fiscal_year.gt" fiscal-year.gt
                         "fiscal_year.gte" fiscal-year.gte
                         "fiscal_year.lt" fiscal-year.lt
                         "fiscal_year.lte" fiscal-year.lte
                         "fiscal_period" fiscal-period
                         "fiscal_period.any_of" fiscal-period.any-of
                         "fiscal_period.gt" fiscal-period.gt
                         "fiscal_period.gte" fiscal-period.gte
                         "fiscal_period.lt" fiscal-period.lt
                         "fiscal_period.lte" fiscal-period.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-firms (&key
     benzinga-id
     benzinga-id.any-of
     benzinga-id.gt
     benzinga-id.gte
     benzinga-id.lt
     benzinga-id.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/firms
get_benzinga_v1_firms. A comprehensive database of financial firms, tracking unique identifiers, names, and basic metadata for various financial institutions and research firms. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/firms"
           :query (query
                         "benzinga_id" benzinga-id
                         "benzinga_id.any_of" benzinga-id.any-of
                         "benzinga_id.gt" benzinga-id.gt
                         "benzinga_id.gte" benzinga-id.gte
                         "benzinga_id.lt" benzinga-id.lt
                         "benzinga_id.lte" benzinga-id.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-guidance (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     positioning
     positioning.any-of
     positioning.gt
     positioning.gte
     positioning.lt
     positioning.lte
     importance
     importance.any-of
     importance.gt
     importance.gte
     importance.lt
     importance.lte
     last-updated
     last-updated.any-of
     last-updated.gt
     last-updated.gte
     last-updated.lt
     last-updated.lte
     fiscal-year
     fiscal-year.any-of
     fiscal-year.gt
     fiscal-year.gte
     fiscal-year.lt
     fiscal-year.lte
     fiscal-period
     fiscal-period.any-of
     fiscal-period.gt
     fiscal-period.gte
     fiscal-period.lt
     fiscal-period.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/guidance
get_benzinga_v1_guidance. A comprehensive database of financial guidance and earnings estimates for various companies, capturing key metrics related to earnings per share (EPS) and revenue projections across different fiscal periods. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/guidance"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "positioning" positioning
                         "positioning.any_of" positioning.any-of
                         "positioning.gt" positioning.gt
                         "positioning.gte" positioning.gte
                         "positioning.lt" positioning.lt
                         "positioning.lte" positioning.lte
                         "importance" importance
                         "importance.any_of" importance.any-of
                         "importance.gt" importance.gt
                         "importance.gte" importance.gte
                         "importance.lt" importance.lt
                         "importance.lte" importance.lte
                         "last_updated" last-updated
                         "last_updated.any_of" last-updated.any-of
                         "last_updated.gt" last-updated.gt
                         "last_updated.gte" last-updated.gte
                         "last_updated.lt" last-updated.lt
                         "last_updated.lte" last-updated.lte
                         "fiscal_year" fiscal-year
                         "fiscal_year.any_of" fiscal-year.any-of
                         "fiscal_year.gt" fiscal-year.gt
                         "fiscal_year.gte" fiscal-year.gte
                         "fiscal_year.lt" fiscal-year.lt
                         "fiscal_year.lte" fiscal-year.lte
                         "fiscal_period" fiscal-period
                         "fiscal_period.any_of" fiscal-period.any-of
                         "fiscal_period.gt" fiscal-period.gt
                         "fiscal_period.gte" fiscal-period.gte
                         "fiscal_period.lt" fiscal-period.lt
                         "fiscal_period.lte" fiscal-period.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v1-ratings (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     importance
     importance.gt
     importance.gte
     importance.lt
     importance.lte
     last-updated
     last-updated.gt
     last-updated.gte
     last-updated.lt
     last-updated.lte
     rating-action
     rating-action.any-of
     rating-action.gt
     rating-action.gte
     rating-action.lt
     rating-action.lte
     price-target-action
     price-target-action.any-of
     price-target-action.gt
     price-target-action.gte
     price-target-action.lt
     price-target-action.lte
     benzinga-id
     benzinga-id.any-of
     benzinga-id.gt
     benzinga-id.gte
     benzinga-id.lt
     benzinga-id.lte
     benzinga-analyst-id
     benzinga-analyst-id.any-of
     benzinga-analyst-id.gt
     benzinga-analyst-id.gte
     benzinga-analyst-id.lt
     benzinga-analyst-id.lte
     benzinga-firm-id
     benzinga-firm-id.any-of
     benzinga-firm-id.gt
     benzinga-firm-id.gte
     benzinga-firm-id.lt
     benzinga-firm-id.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v1/ratings
get_benzinga_v1_ratings. This table contains analyst ratings and price target data from investment firms, tracking rating changes (upgrades, downgrades, initiates coverage, etc.) and price target adjustments for publicly traded companies. Each record includes the analyst details, company information,... Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v1/ratings"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "importance" importance
                         "importance.gt" importance.gt
                         "importance.gte" importance.gte
                         "importance.lt" importance.lt
                         "importance.lte" importance.lte
                         "last_updated" last-updated
                         "last_updated.gt" last-updated.gt
                         "last_updated.gte" last-updated.gte
                         "last_updated.lt" last-updated.lt
                         "last_updated.lte" last-updated.lte
                         "rating_action" rating-action
                         "rating_action.any_of" rating-action.any-of
                         "rating_action.gt" rating-action.gt
                         "rating_action.gte" rating-action.gte
                         "rating_action.lt" rating-action.lt
                         "rating_action.lte" rating-action.lte
                         "price_target_action" price-target-action
                         "price_target_action.any_of" price-target-action.any-of
                         "price_target_action.gt" price-target-action.gt
                         "price_target_action.gte" price-target-action.gte
                         "price_target_action.lt" price-target-action.lt
                         "price_target_action.lte" price-target-action.lte
                         "benzinga_id" benzinga-id
                         "benzinga_id.any_of" benzinga-id.any-of
                         "benzinga_id.gt" benzinga-id.gt
                         "benzinga_id.gte" benzinga-id.gte
                         "benzinga_id.lt" benzinga-id.lt
                         "benzinga_id.lte" benzinga-id.lte
                         "benzinga_analyst_id" benzinga-analyst-id
                         "benzinga_analyst_id.any_of" benzinga-analyst-id.any-of
                         "benzinga_analyst_id.gt" benzinga-analyst-id.gt
                         "benzinga_analyst_id.gte" benzinga-analyst-id.gte
                         "benzinga_analyst_id.lt" benzinga-analyst-id.lt
                         "benzinga_analyst_id.lte" benzinga-analyst-id.lte
                         "benzinga_firm_id" benzinga-firm-id
                         "benzinga_firm_id.any_of" benzinga-firm-id.any-of
                         "benzinga_firm_id.gt" benzinga-firm-id.gt
                         "benzinga_firm_id.gte" benzinga-firm-id.gte
                         "benzinga_firm_id.lt" benzinga-firm-id.lt
                         "benzinga_firm_id.lte" benzinga-firm-id.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-benzinga-v2-news (&key
     published
     published.gt
     published.gte
     published.lt
     published.lte
     channels
     channels.all-of
     channels.any-of
     tags
     tags.all-of
     tags.any-of
     author
     author.any-of
     author.gt
     author.gte
     author.lt
     author.lte
     stocks
     stocks.all-of
     stocks.any-of
     tickers
     tickers.all-of
     tickers.any-of
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /benzinga/v2/news
get_benzinga_v2_news. A comprehensive news article database from Benzinga, containing detailed information about financial news articles including metadata, content, and associated financial information. Pass :FOLLOW T to walk next_url."
  (api-get "/benzinga/v2/news"
           :query (query
                         "published" published
                         "published.gt" published.gt
                         "published.gte" published.gte
                         "published.lt" published.lt
                         "published.lte" published.lte
                         "channels" channels
                         "channels.all_of" channels.all-of
                         "channels.any_of" channels.any-of
                         "tags" tags
                         "tags.all_of" tags.all-of
                         "tags.any_of" tags.any-of
                         "author" author
                         "author.any_of" author.any-of
                         "author.gt" author.gt
                         "author.gte" author.gte
                         "author.lt" author.lt
                         "author.lte" author.lte
                         "stocks" stocks
                         "stocks.all_of" stocks.all-of
                         "stocks.any_of" stocks.any-of
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-consumer-spending-eu-v1-merchant-aggregates (&key
     transaction-date
     transaction-date.gt
     transaction-date.gte
     transaction-date.lt
     transaction-date.lte
     name
     name.any-of
     name.gt
     name.gte
     name.lt
     name.lte
     user-country
     user-country.any-of
     channel
     channel.any-of
     consumer-type
     consumer-type.any-of
     parent-name
     parent-name.any-of
     parent-name.gt
     parent-name.gte
     parent-name.lt
     parent-name.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /consumer-spending/eu/v1/merchant-aggregates
get_consumer-spending_eu_v1_merchant-aggregates. Aggregated consumer transactions from European credit card panels, structured for flexible analysis and faster access to insights. Each row represents daily credit card, debit card, or open banking transactions (7-day lag from transaction date) at a tagged merchant or payment... Pass :FOLLOW T to walk next_url."
  (api-get "/consumer-spending/eu/v1/merchant-aggregates"
           :query (query
                         "transaction_date" transaction-date
                         "transaction_date.gt" transaction-date.gt
                         "transaction_date.gte" transaction-date.gte
                         "transaction_date.lt" transaction-date.lt
                         "transaction_date.lte" transaction-date.lte
                         "name" name
                         "name.any_of" name.any-of
                         "name.gt" name.gt
                         "name.gte" name.gte
                         "name.lt" name.lt
                         "name.lte" name.lte
                         "user_country" user-country
                         "user_country.any_of" user-country.any-of
                         "channel" channel
                         "channel.any_of" channel.any-of
                         "consumer_type" consumer-type
                         "consumer_type.any_of" consumer-type.any-of
                         "parent_name" parent-name
                         "parent_name.any_of" parent-name.any-of
                         "parent_name.gt" parent-name.gt
                         "parent_name.gte" parent-name.gte
                         "parent_name.lt" parent-name.lt
                         "parent_name.lte" parent-name.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-consumer-spending-eu-v1-merchant-hierarchy (&key
     lookup-name
     lookup-name.any-of
     lookup-name.gt
     lookup-name.gte
     lookup-name.lt
     lookup-name.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     listing-status
     listing-status.any-of
     active-from
     active-from.gt
     active-from.gte
     active-from.lt
     active-from.lte
     active-to
     active-to.gt
     active-to.gte
     active-to.lt
     active-to.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /consumer-spending/eu/v1/merchant-hierarchy
get_consumer-spending_eu_v1_merchant-hierarchy. Reference data mapping merchants to parent companies, tickers, sectors, and industries across Fable's European consumer transaction panel. Each row represents a single merchant with its corporate hierarchy and classification metadata. Weekly snapshots contain ~3,500 merchants... Pass :FOLLOW T to walk next_url."
  (api-get "/consumer-spending/eu/v1/merchant-hierarchy"
           :query (query
                         "lookup_name" lookup-name
                         "lookup_name.any_of" lookup-name.any-of
                         "lookup_name.gt" lookup-name.gt
                         "lookup_name.gte" lookup-name.gte
                         "lookup_name.lt" lookup-name.lt
                         "lookup_name.lte" lookup-name.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "listing_status" listing-status
                         "listing_status.any_of" listing-status.any-of
                         "active_from" active-from
                         "active_from.gt" active-from.gt
                         "active_from.gte" active-from.gte
                         "active_from.lt" active-from.lt
                         "active_from.lte" active-from.lte
                         "active_to" active-to
                         "active_to.gt" active-to.gt
                         "active_to.gte" active-to.gte
                         "active_to.lt" active-to.lt
                         "active_to.lte" active-to.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-crypto-v1-exchanges (&key limit (follow nil) (max-pages *max-pages*) (cache t))
  "GET /crypto/v1/exchanges
get_crypto_v1_exchanges. Global cryptocurrency exchanges and digital asset trading platforms, including major centralized exchanges (Coinbase, Binance, Bitfinex, etc.) that facilitate trading of cryptocurrencies and digital tokens worldwide. Pass :FOLLOW T to walk next_url."
  (api-get "/crypto/v1/exchanges"
           :query (query
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-etf-global-v1-analytics (&key
     composite-ticker
     composite-ticker.any-of
     composite-ticker.gt
     composite-ticker.gte
     composite-ticker.lt
     composite-ticker.lte
     processed-date
     processed-date.gt
     processed-date.gte
     processed-date.lt
     processed-date.lte
     effective-date
     effective-date.gt
     effective-date.gte
     effective-date.lt
     effective-date.lte
     risk-total-score
     risk-total-score.gt
     risk-total-score.gte
     risk-total-score.lt
     risk-total-score.lte
     reward-score
     reward-score.gt
     reward-score.gte
     reward-score.lt
     reward-score.lte
     quant-total-score
     quant-total-score.gt
     quant-total-score.gte
     quant-total-score.lt
     quant-total-score.lte
     quant-grade
     quant-grade.any-of
     quant-grade.gt
     quant-grade.gte
     quant-grade.lt
     quant-grade.lte
     quant-composite-technical
     quant-composite-technical.gt
     quant-composite-technical.gte
     quant-composite-technical.lt
     quant-composite-technical.lte
     quant-composite-sentiment
     quant-composite-sentiment.gt
     quant-composite-sentiment.gte
     quant-composite-sentiment.lt
     quant-composite-sentiment.lte
     quant-composite-behavioral
     quant-composite-behavioral.gt
     quant-composite-behavioral.gte
     quant-composite-behavioral.lt
     quant-composite-behavioral.lte
     quant-composite-fundamental
     quant-composite-fundamental.gt
     quant-composite-fundamental.gte
     quant-composite-fundamental.lt
     quant-composite-fundamental.lte
     quant-composite-global
     quant-composite-global.gt
     quant-composite-global.gte
     quant-composite-global.lt
     quant-composite-global.lte
     quant-composite-quality
     quant-composite-quality.gt
     quant-composite-quality.gte
     quant-composite-quality.lt
     quant-composite-quality.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /etf-global/v1/analytics
get_etf-global_v1_analytics. ETF Global analytics data containing risk scores, reward metrics, and quantitative analysis for ETF composite tickers. Pass :FOLLOW T to walk next_url."
  (api-get "/etf-global/v1/analytics"
           :query (query
                         "composite_ticker" (canonicalize-ticker composite-ticker)
                         "composite_ticker.any_of" (canonicalize-ticker composite-ticker.any-of)
                         "composite_ticker.gt" (canonicalize-ticker composite-ticker.gt)
                         "composite_ticker.gte" (canonicalize-ticker composite-ticker.gte)
                         "composite_ticker.lt" (canonicalize-ticker composite-ticker.lt)
                         "composite_ticker.lte" (canonicalize-ticker composite-ticker.lte)
                         "processed_date" processed-date
                         "processed_date.gt" processed-date.gt
                         "processed_date.gte" processed-date.gte
                         "processed_date.lt" processed-date.lt
                         "processed_date.lte" processed-date.lte
                         "effective_date" effective-date
                         "effective_date.gt" effective-date.gt
                         "effective_date.gte" effective-date.gte
                         "effective_date.lt" effective-date.lt
                         "effective_date.lte" effective-date.lte
                         "risk_total_score" risk-total-score
                         "risk_total_score.gt" risk-total-score.gt
                         "risk_total_score.gte" risk-total-score.gte
                         "risk_total_score.lt" risk-total-score.lt
                         "risk_total_score.lte" risk-total-score.lte
                         "reward_score" reward-score
                         "reward_score.gt" reward-score.gt
                         "reward_score.gte" reward-score.gte
                         "reward_score.lt" reward-score.lt
                         "reward_score.lte" reward-score.lte
                         "quant_total_score" quant-total-score
                         "quant_total_score.gt" quant-total-score.gt
                         "quant_total_score.gte" quant-total-score.gte
                         "quant_total_score.lt" quant-total-score.lt
                         "quant_total_score.lte" quant-total-score.lte
                         "quant_grade" quant-grade
                         "quant_grade.any_of" quant-grade.any-of
                         "quant_grade.gt" quant-grade.gt
                         "quant_grade.gte" quant-grade.gte
                         "quant_grade.lt" quant-grade.lt
                         "quant_grade.lte" quant-grade.lte
                         "quant_composite_technical" quant-composite-technical
                         "quant_composite_technical.gt" quant-composite-technical.gt
                         "quant_composite_technical.gte" quant-composite-technical.gte
                         "quant_composite_technical.lt" quant-composite-technical.lt
                         "quant_composite_technical.lte" quant-composite-technical.lte
                         "quant_composite_sentiment" quant-composite-sentiment
                         "quant_composite_sentiment.gt" quant-composite-sentiment.gt
                         "quant_composite_sentiment.gte" quant-composite-sentiment.gte
                         "quant_composite_sentiment.lt" quant-composite-sentiment.lt
                         "quant_composite_sentiment.lte" quant-composite-sentiment.lte
                         "quant_composite_behavioral" quant-composite-behavioral
                         "quant_composite_behavioral.gt" quant-composite-behavioral.gt
                         "quant_composite_behavioral.gte" quant-composite-behavioral.gte
                         "quant_composite_behavioral.lt" quant-composite-behavioral.lt
                         "quant_composite_behavioral.lte" quant-composite-behavioral.lte
                         "quant_composite_fundamental" quant-composite-fundamental
                         "quant_composite_fundamental.gt" quant-composite-fundamental.gt
                         "quant_composite_fundamental.gte" quant-composite-fundamental.gte
                         "quant_composite_fundamental.lt" quant-composite-fundamental.lt
                         "quant_composite_fundamental.lte" quant-composite-fundamental.lte
                         "quant_composite_global" quant-composite-global
                         "quant_composite_global.gt" quant-composite-global.gt
                         "quant_composite_global.gte" quant-composite-global.gte
                         "quant_composite_global.lt" quant-composite-global.lt
                         "quant_composite_global.lte" quant-composite-global.lte
                         "quant_composite_quality" quant-composite-quality
                         "quant_composite_quality.gt" quant-composite-quality.gt
                         "quant_composite_quality.gte" quant-composite-quality.gte
                         "quant_composite_quality.lt" quant-composite-quality.lt
                         "quant_composite_quality.lte" quant-composite-quality.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-etf-global-v1-constituents (&key
     composite-ticker
     composite-ticker.any-of
     composite-ticker.gt
     composite-ticker.gte
     composite-ticker.lt
     composite-ticker.lte
     constituent-ticker
     constituent-ticker.any-of
     constituent-ticker.gt
     constituent-ticker.gte
     constituent-ticker.lt
     constituent-ticker.lte
     effective-date
     effective-date.gt
     effective-date.gte
     effective-date.lt
     effective-date.lte
     processed-date
     processed-date.gt
     processed-date.gte
     processed-date.lt
     processed-date.lte
     us-code
     us-code.any-of
     us-code.gt
     us-code.gte
     us-code.lt
     us-code.lte
     isin
     isin.any-of
     isin.gt
     isin.gte
     isin.lt
     isin.lte
     figi
     figi.any-of
     figi.gt
     figi.gte
     figi.lt
     figi.lte
     sedol
     sedol.any-of
     sedol.gt
     sedol.gte
     sedol.lt
     sedol.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /etf-global/v1/constituents
get_etf-global_v1_constituents. ETF Global constituents data containing detailed information about the securities held within ETFs, including weights, market values, and security identifiers. Pass :FOLLOW T to walk next_url."
  (api-get "/etf-global/v1/constituents"
           :query (query
                         "composite_ticker" (canonicalize-ticker composite-ticker)
                         "composite_ticker.any_of" (canonicalize-ticker composite-ticker.any-of)
                         "composite_ticker.gt" (canonicalize-ticker composite-ticker.gt)
                         "composite_ticker.gte" (canonicalize-ticker composite-ticker.gte)
                         "composite_ticker.lt" (canonicalize-ticker composite-ticker.lt)
                         "composite_ticker.lte" (canonicalize-ticker composite-ticker.lte)
                         "constituent_ticker" (canonicalize-ticker constituent-ticker)
                         "constituent_ticker.any_of" (canonicalize-ticker constituent-ticker.any-of)
                         "constituent_ticker.gt" (canonicalize-ticker constituent-ticker.gt)
                         "constituent_ticker.gte" (canonicalize-ticker constituent-ticker.gte)
                         "constituent_ticker.lt" (canonicalize-ticker constituent-ticker.lt)
                         "constituent_ticker.lte" (canonicalize-ticker constituent-ticker.lte)
                         "effective_date" effective-date
                         "effective_date.gt" effective-date.gt
                         "effective_date.gte" effective-date.gte
                         "effective_date.lt" effective-date.lt
                         "effective_date.lte" effective-date.lte
                         "processed_date" processed-date
                         "processed_date.gt" processed-date.gt
                         "processed_date.gte" processed-date.gte
                         "processed_date.lt" processed-date.lt
                         "processed_date.lte" processed-date.lte
                         "us_code" us-code
                         "us_code.any_of" us-code.any-of
                         "us_code.gt" us-code.gt
                         "us_code.gte" us-code.gte
                         "us_code.lt" us-code.lt
                         "us_code.lte" us-code.lte
                         "isin" isin
                         "isin.any_of" isin.any-of
                         "isin.gt" isin.gt
                         "isin.gte" isin.gte
                         "isin.lt" isin.lt
                         "isin.lte" isin.lte
                         "figi" figi
                         "figi.any_of" figi.any-of
                         "figi.gt" figi.gt
                         "figi.gte" figi.gte
                         "figi.lt" figi.lt
                         "figi.lte" figi.lte
                         "sedol" sedol
                         "sedol.any_of" sedol.any-of
                         "sedol.gt" sedol.gt
                         "sedol.gte" sedol.gte
                         "sedol.lt" sedol.lt
                         "sedol.lte" sedol.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-etf-global-v1-fund-flows (&key
     processed-date
     processed-date.gt
     processed-date.gte
     processed-date.lt
     processed-date.lte
     effective-date
     effective-date.gt
     effective-date.gte
     effective-date.lt
     effective-date.lte
     composite-ticker
     composite-ticker.any-of
     composite-ticker.gt
     composite-ticker.gte
     composite-ticker.lt
     composite-ticker.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /etf-global/v1/fund-flows
get_etf-global_v1_fund-flows. ETF Global fund flow data containing information about ETF share movements, net asset values, and fund flow metrics. Pass :FOLLOW T to walk next_url."
  (api-get "/etf-global/v1/fund-flows"
           :query (query
                         "processed_date" processed-date
                         "processed_date.gt" processed-date.gt
                         "processed_date.gte" processed-date.gte
                         "processed_date.lt" processed-date.lt
                         "processed_date.lte" processed-date.lte
                         "effective_date" effective-date
                         "effective_date.gt" effective-date.gt
                         "effective_date.gte" effective-date.gte
                         "effective_date.lt" effective-date.lt
                         "effective_date.lte" effective-date.lte
                         "composite_ticker" (canonicalize-ticker composite-ticker)
                         "composite_ticker.any_of" (canonicalize-ticker composite-ticker.any-of)
                         "composite_ticker.gt" (canonicalize-ticker composite-ticker.gt)
                         "composite_ticker.gte" (canonicalize-ticker composite-ticker.gte)
                         "composite_ticker.lt" (canonicalize-ticker composite-ticker.lt)
                         "composite_ticker.lte" (canonicalize-ticker composite-ticker.lte)
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-etf-global-v1-profiles (&key
     processed-date
     processed-date.gt
     processed-date.gte
     processed-date.lt
     processed-date.lte
     effective-date
     effective-date.gt
     effective-date.gte
     effective-date.lt
     effective-date.lte
     composite-ticker
     composite-ticker.any-of
     composite-ticker.gt
     composite-ticker.gte
     composite-ticker.lt
     composite-ticker.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /etf-global/v1/profiles
get_etf-global_v1_profiles. ETF Global industry profile data containing comprehensive ETF metadata including financial metrics, operational details, and exposure information. Pass :FOLLOW T to walk next_url."
  (api-get "/etf-global/v1/profiles"
           :query (query
                         "processed_date" processed-date
                         "processed_date.gt" processed-date.gt
                         "processed_date.gte" processed-date.gte
                         "processed_date.lt" processed-date.lt
                         "processed_date.lte" processed-date.lte
                         "effective_date" effective-date
                         "effective_date.gt" effective-date.gt
                         "effective_date.gte" effective-date.gte
                         "effective_date.lt" effective-date.lt
                         "effective_date.lte" effective-date.lte
                         "composite_ticker" (canonicalize-ticker composite-ticker)
                         "composite_ticker.any_of" (canonicalize-ticker composite-ticker.any-of)
                         "composite_ticker.gt" (canonicalize-ticker composite-ticker.gt)
                         "composite_ticker.gte" (canonicalize-ticker composite-ticker.gte)
                         "composite_ticker.lt" (canonicalize-ticker composite-ticker.lt)
                         "composite_ticker.lte" (canonicalize-ticker composite-ticker.lte)
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-etf-global-v1-taxonomies (&key
     processed-date
     processed-date.gt
     processed-date.gte
     processed-date.lt
     processed-date.lte
     effective-date
     effective-date.gt
     effective-date.gte
     effective-date.lt
     effective-date.lte
     composite-ticker
     composite-ticker.any-of
     composite-ticker.gt
     composite-ticker.gte
     composite-ticker.lt
     composite-ticker.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /etf-global/v1/taxonomies
get_etf-global_v1_taxonomies. ETF Global taxonomy data containing detailed classification and categorization information for ETFs including investment strategy, methodology, and structural characteristics. Pass :FOLLOW T to walk next_url."
  (api-get "/etf-global/v1/taxonomies"
           :query (query
                         "processed_date" processed-date
                         "processed_date.gt" processed-date.gt
                         "processed_date.gte" processed-date.gte
                         "processed_date.lt" processed-date.lt
                         "processed_date.lte" processed-date.lte
                         "effective_date" effective-date
                         "effective_date.gt" effective-date.gt
                         "effective_date.gte" effective-date.gte
                         "effective_date.lt" effective-date.lt
                         "effective_date.lte" effective-date.lte
                         "composite_ticker" (canonicalize-ticker composite-ticker)
                         "composite_ticker.any_of" (canonicalize-ticker composite-ticker.any-of)
                         "composite_ticker.gt" (canonicalize-ticker composite-ticker.gt)
                         "composite_ticker.gte" (canonicalize-ticker composite-ticker.gte)
                         "composite_ticker.lt" (canonicalize-ticker composite-ticker.lt)
                         "composite_ticker.lte" (canonicalize-ticker composite-ticker.lte)
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-fed-v1-funding-conditions (&key
     date
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /fed/v1/funding-conditions
get_fed_v1_funding-conditions. Daily U.S. money-market funding conditions from the Federal Reserve and the Federal Reserve Bank of New York, including the Federal Funds Effective Rate, SOFR, OBFR, tri-party general collateral repo rates, Treasury-collateralized overnight reverse repo and repo operation... Pass :FOLLOW T to walk next_url."
  (api-get "/fed/v1/funding-conditions"
           :query (query
                         "date" date
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-fed-v1-inflation (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /fed/v1/inflation
get_fed_v1_inflation. A table tracking inflation and price indices, including Consumer Price Index (CPI) and Personal Consumption Expenditures (PCE) metrics over time. Pass :FOLLOW T to walk next_url."
  (api-get "/fed/v1/inflation"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-fed-v1-inflation-expectations (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /fed/v1/inflation-expectations
get_fed_v1_inflation-expectations. A table tracking inflation expectations from both market-based and economic model perspectives across different time horizons. Pass :FOLLOW T to walk next_url."
  (api-get "/fed/v1/inflation-expectations"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-fed-v1-labor-market (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /fed/v1/labor-market
get_fed_v1_labor-market. Labor market indicators from the Federal Reserve, including unemployment rate, labor force participation, average hourly earnings, and job openings data. Pass :FOLLOW T to walk next_url."
  (api-get "/fed/v1/labor-market"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-fed-v1-treasury-yields (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /fed/v1/treasury-yields
get_fed_v1_treasury-yields. A record of U.S. Treasury bond yields across various maturity periods, tracking historical interest rates from short-term to long-term government securities. Pass :FOLLOW T to walk next_url."
  (api-get "/fed/v1/treasury-yields"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-forex-v1-exchanges (&key limit (follow nil) (max-pages *max-pages*) (cache t))
  "GET /forex/v1/exchanges
get_forex_v1_exchanges. Global foreign exchange (FX) trading venues and market infrastructure, including electronic trading platforms, banks, and other institutions facilitating currency pair trading worldwide. Pass :FOLLOW T to walk next_url."
  (api-get "/forex/v1/exchanges"
           :query (query
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-aggregates (ticker
    &key
     resolution
     window-start
     limit
     window-start.gte
     window-start.gt
     window-start.lte
     window-start.lt
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /futures/v1/aggs/{ticker}
AggregatesV1. Get aggregates for a contract in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/futures/v1/aggs/~A"
                   (ticker-segment ticker))
           :query (query
                         "resolution" resolution
                         "window_start" window-start
                         "limit" limit
                         "window_start.gte" window-start.gte
                         "window_start.gt" window-start.gt
                         "window_start.lte" window-start.lte
                         "window_start.lt" window-start.lt
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-contracts (&key
     date
     date.gt
     date.gte
     date.lt
     date.lte
     product-code
     product-code.any-of
     product-code.gt
     product-code.gte
     product-code.lt
     product-code.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     active
     type
     type.any-of
     first-trade-date
     first-trade-date.gt
     first-trade-date.gte
     first-trade-date.lt
     first-trade-date.lte
     last-trade-date
     last-trade-date.gt
     last-trade-date.gte
     last-trade-date.lt
     last-trade-date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /futures/v1/contracts
get_futures_v1_contracts. The Contracts API provides a single source for discovering all listed futures contracts and retrieving complete contract specifications. You can query the full contract index with filters for product code, trade dates, active status, and date, returning key attributes such as... Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/contracts"
           :query (query
                         "date" date
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "product_code" product-code
                         "product_code.any_of" product-code.any-of
                         "product_code.gt" product-code.gt
                         "product_code.gte" product-code.gte
                         "product_code.lt" product-code.lt
                         "product_code.lte" product-code.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "active" active
                         "type" type
                         "type.any_of" type.any-of
                         "first_trade_date" first-trade-date
                         "first_trade_date.gt" first-trade-date.gt
                         "first_trade_date.gte" first-trade-date.gte
                         "first_trade_date.lt" first-trade-date.lt
                         "first_trade_date.lte" first-trade-date.lte
                         "last_trade_date" last-trade-date
                         "last_trade_date.gt" last-trade-date.gt
                         "last_trade_date.gte" last-trade-date.gte
                         "last_trade_date.lt" last-trade-date.lt
                         "last_trade_date.lte" last-trade-date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-exchanges (&key limit (follow nil) (max-pages *max-pages*) (cache t))
  "GET /futures/v1/exchanges
get_futures_v1_exchanges. US futures exchanges and trading venues including major derivatives exchanges (CME, CBOT, NYMEX, COMEX) and other futures market infrastructure for commodity, financial, and other derivative contract trading. Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/exchanges"
           :query (query
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-market-status (&key
     product-code
     product-code.any-of
     product-code.gt
     product-code.gte
     product-code.lt
     product-code.lte
     limit
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /futures/v1/market-status
get_futures_v1_market-status. Retrieve the current market status for a specific product or products. This endpoint returns real-time indicators, such as open, pause, close, for futures products, along with the corresponding exchange and product codes and an evaluation timestamp. This information enables... Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/market-status"
           :query (query
                         "product_code" product-code
                         "product_code.any_of" product-code.any-of
                         "product_code.gt" product-code.gt
                         "product_code.gte" product-code.gte
                         "product_code.lt" product-code.lt
                         "product_code.lte" product-code.lte
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-products (&key
     name
     name.any-of
     name.gt
     name.gte
     name.lt
     name.lte
     product-code
     product-code.any-of
     product-code.gt
     product-code.gte
     product-code.lt
     product-code.lte
     date
     date.gt
     date.gte
     date.lt
     date.lte
     trading-venue
     trading-venue.any-of
     trading-venue.gt
     trading-venue.gte
     trading-venue.lt
     trading-venue.lte
     sector
     sector.any-of
     sub-sector
     sub-sector.any-of
     asset-class
     asset-class.any-of
     asset-sub-class
     asset-sub-class.any-of
     type
     type.any-of
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /futures/v1/products
get_futures_v1_products. The Products API is a unified source for discovering all supported futures products and retrieving full product specifications. It returns the complete product universe with product codes, names, exchange identifiers, sector and asset class classifications, product type,... Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/products"
           :query (query
                         "name" name
                         "name.any_of" name.any-of
                         "name.gt" name.gt
                         "name.gte" name.gte
                         "name.lt" name.lt
                         "name.lte" name.lte
                         "product_code" product-code
                         "product_code.any_of" product-code.any-of
                         "product_code.gt" product-code.gt
                         "product_code.gte" product-code.gte
                         "product_code.lt" product-code.lt
                         "product_code.lte" product-code.lte
                         "date" date
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "trading_venue" trading-venue
                         "trading_venue.any_of" trading-venue.any-of
                         "trading_venue.gt" trading-venue.gt
                         "trading_venue.gte" trading-venue.gte
                         "trading_venue.lt" trading-venue.lt
                         "trading_venue.lte" trading-venue.lte
                         "sector" sector
                         "sector.any_of" sector.any-of
                         "sub_sector" sub-sector
                         "sub_sector.any_of" sub-sector.any-of
                         "asset_class" asset-class
                         "asset_class.any_of" asset-class.any-of
                         "asset_sub_class" asset-sub-class
                         "asset_sub_class.any_of" asset-sub-class.any-of
                         "type" type
                         "type.any_of" type.any-of
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-quotes-ticker (ticker
    &key
     timestamp
     timestamp.gt
     timestamp.gte
     timestamp.lt
     timestamp.lte
     session-end-date
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /futures/v1/quotes/{ticker}
get_futures_v1_quotes_ticker. Retrieve quote data for a specified futures contract ticker. Each record includes the best bid and offer prices, sizes, and timestamps, reflecting the prevailing quote environment at each moment. This endpoint supports detailed analysis of price dynamics and liquidity... Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/futures/v1/quotes/~A"
                   (ticker-segment ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gt" timestamp.gt
                         "timestamp.gte" timestamp.gte
                         "timestamp.lt" timestamp.lt
                         "timestamp.lte" timestamp.lte
                         "session_end_date" session-end-date
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-schedules (&key
     product-code
     product-code.any-of
     product-code.gt
     product-code.gte
     product-code.lt
     product-code.lte
     session-end-date
     session-end-date.gt
     session-end-date.gte
     session-end-date.lt
     session-end-date.lte
     trading-venue
     trading-venue.any-of
     trading-venue.gt
     trading-venue.gte
     trading-venue.lt
     trading-venue.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /futures/v1/schedules
get_futures_v1_schedules. The Schedules API provides a unified way to retrieve trading schedules for futures markets, returning precise session open and close times, intraday breaks, and any adjustments for holidays or special events. You can filter schedules by session_end_date or retrieve the... Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/schedules"
           :query (query
                         "product_code" product-code
                         "product_code.any_of" product-code.any-of
                         "product_code.gt" product-code.gt
                         "product_code.gte" product-code.gte
                         "product_code.lt" product-code.lt
                         "product_code.lte" product-code.lte
                         "session_end_date" session-end-date
                         "session_end_date.gt" session-end-date.gt
                         "session_end_date.gte" session-end-date.gte
                         "session_end_date.lt" session-end-date.lt
                         "session_end_date.lte" session-end-date.lte
                         "trading_venue" trading-venue
                         "trading_venue.any_of" trading-venue.any-of
                         "trading_venue.gt" trading-venue.gt
                         "trading_venue.gte" trading-venue.gte
                         "trading_venue.lt" trading-venue.lt
                         "trading_venue.lte" trading-venue.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-snapshot (&key
     product-code
     product-code.any-of
     product-code.gt
     product-code.gte
     product-code.lt
     product-code.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /futures/v1/snapshot
get_futures_v1_snapshot. Retrieve a snapshot of the most recent futures contract data. Pass :FOLLOW T to walk next_url."
  (api-get "/futures/v1/snapshot"
           :query (query
                         "product_code" product-code
                         "product_code.any_of" product-code.any-of
                         "product_code.gt" product-code.gt
                         "product_code.gte" product-code.gte
                         "product_code.lt" product-code.lt
                         "product_code.lte" product-code.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-futures-v1-trades-ticker (ticker
    &key
     timestamp
     timestamp.gt
     timestamp.gte
     timestamp.lt
     timestamp.lte
     session-end-date
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /futures/v1/trades/{ticker}
get_futures_v1_trades_ticker. Retrieve comprehensive, tick-level trade data for a specified futures contract ticker over a defined time range. Each record includes the trade price, size, session start date, and precise timestamps, capturing individual trade events throughout the period. This granular data... Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/futures/v1/trades/~A"
                   (ticker-segment ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gt" timestamp.gt
                         "timestamp.gte" timestamp.gte
                         "timestamp.lt" timestamp.lt
                         "timestamp.lte" timestamp.lte
                         "session_end_date" session-end-date
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-v1-exchanges (&key limit (follow nil) (max-pages *max-pages*) (cache t))
  "GET /options/v1/exchanges
get_options_v1_exchanges. US options exchanges and trading venues including traditional options exchanges (CBOE, ISE, etc.), Securities Information Processors (SIP), and other options market infrastructure for derivatives trading. Pass :FOLLOW T to walk next_url."
  (api-get "/options/v1/exchanges"
           :query (query
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-v3-quotes-ticker (ticker
    &key
     timestamp
     timestamp.gt
     timestamp.gte
     timestamp.lt
     timestamp.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /options/v3/quotes/{ticker}
get_options_v3_quotes_ticker. Contains NBBO (National Best Bid and Offer) quote records for US options contracts, capturing bid/ask prices, sizes, and exchange attribution at nanosecond precision. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/options/v3/quotes/~A"
                   (ticker-segment ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gt" timestamp.gt
                         "timestamp.gte" timestamp.gte
                         "timestamp.lt" timestamp.lt
                         "timestamp.lte" timestamp.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-v3-trades-ticker (ticker
    &key
     timestamp
     timestamp.gt
     timestamp.gte
     timestamp.lt
     timestamp.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /options/v3/trades/{ticker}
get_options_v3_trades_ticker. Contains individual trade transactions for US options contracts, capturing trade execution details including pricing, timing, and exchange information. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/options/v3/trades/~A"
                   (ticker-segment ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gt" timestamp.gt
                         "timestamp.gte" timestamp.gte
                         "timestamp.lt" timestamp.lt
                         "timestamp.lte" timestamp.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-dev-trades-ticker (ticker
    &key
     sip-timestamp
     sip-timestamp.gt
     sip-timestamp.gte
     sip-timestamp.lt
     sip-timestamp.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /stocks/dev/trades/{ticker}
get_stocks_dev_trades_ticker. Contains individual trade transactions for US stocks, capturing trade execution details including pricing, timing, and exchange information. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/stocks/dev/trades/~A"
                   (ticker-segment ticker))
           :query (query
                         "sip_timestamp" sip-timestamp
                         "sip_timestamp.gt" sip-timestamp.gt
                         "sip_timestamp.gte" sip-timestamp.gte
                         "sip_timestamp.lt" sip-timestamp.lt
                         "sip_timestamp.lte" sip-timestamp.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-10-k-v-x-sections (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     section
     section.any-of
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     period-end
     period-end.gt
     period-end.gte
     period-end.lt
     period-end.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/10-K/vX/sections
get_stocks_filings_10-K_vX_sections. SEC document text sections providing raw text content from specific sections of SEC filings (10-K, 10-Q, etc.). Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/10-K/vX/sections"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "section" section
                         "section.any_of" section.any-of
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "period_end" period-end
                         "period_end.gt" period-end.gt
                         "period_end.gte" period-end.gte
                         "period_end.lt" period-end.lt
                         "period_end.lte" period-end.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-10-k-v-x-0-sections (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     section
     section.any-of
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     period-end
     period-end.gt
     period-end.gte
     period-end.lt
     period-end.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/10-K/vX_0/sections
get_stocks_filings_10-K_vX_0_sections. SEC document text sections providing raw text content from specific sections of SEC filings (10-K, 10-Q, etc.). Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/10-K/vX_0/sections"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "section" section
                         "section.any_of" section.any-of
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "period_end" period-end
                         "period_end.gt" period-end.gt
                         "period_end.gte" period-end.gte
                         "period_end.lt" period-end.lt
                         "period_end.lte" period-end.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-8-k-v-x-disclosures (&key
     cik
     cik.any-of
     tickers
     tickers.all-of
     tickers.any-of
     filing-date
     filing-date.any-of
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     tertiary-category
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/8-K/vX/disclosures
get_stocks_filings_8-K_vX_disclosures. SEC 8-K filing disclosure categorization. A single 8-K filing can produce multiple rows when it covers multiple disclosure types — each row represents one tagged disclosure within the filing, classified into primary, secondary, and tertiary categories with a supporting text... Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/8-K/vX/disclosures"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "filing_date" filing-date
                         "filing_date.any_of" filing-date.any-of
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "tertiary_category" tertiary-category
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-8-k-v-x-text (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     form-type
     form-type.any-of
     form-type.gt
     form-type.gte
     form-type.lt
     form-type.lte
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/8-K/vX/text
get_stocks_filings_8-K_vX_text. SEC 8-K filings text providing parsed content from current report filings. 8-K forms report material events such as earnings, acquisitions, executive changes, and other significant corporate events. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/8-K/vX/text"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "form_type" form-type
                         "form_type.any_of" form-type.any-of
                         "form_type.gt" form-type.gt
                         "form_type.gte" form-type.gte
                         "form_type.lt" form-type.lt
                         "form_type.lte" form-type.lte
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-v-x-13-f (&key
     filer-cik
     filer-cik.any-of
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/vX/13-F
get_stocks_filings_vX_13-F. SEC Form 13F filings data showing institutional investment manager holdings. Form 13F is required to be filed quarterly by institutional investment managers with at least $100 million in qualifying assets under management. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/vX/13-F"
           :query (query
                         "filer_cik" filer-cik
                         "filer_cik.any_of" filer-cik.any-of
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-v-x-form-3 (&key
     issuer-cik
     issuer-cik.any-of
     owner-cik
     owner-cik.any-of
     tickers
     tickers.all-of
     tickers.any-of
     form-type
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/vX/form-3
get_stocks_filings_vX_form-3. SEC Form 3 filings reporting initial statements of beneficial ownership of securities. Filed by corporate insiders (directors, officers, and 10%+ shareholders) when they first acquire a position. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/vX/form-3"
           :query (query
                         "issuer_cik" issuer-cik
                         "issuer_cik.any_of" issuer-cik.any-of
                         "owner_cik" owner-cik
                         "owner_cik.any_of" owner-cik.any-of
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "form_type" form-type
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-v-x-form-4 (&key
     issuer-cik
     issuer-cik.any-of
     owner-cik
     owner-cik.any-of
     tickers
     tickers.all-of
     tickers.any-of
     form-type
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     transaction-code
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/vX/form-4
get_stocks_filings_vX_form-4. SEC Form 4 filings reporting changes in beneficial ownership of securities. Filed by corporate insiders (directors, officers, and 10%+ shareholders) within two business days of a transaction. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/vX/form-4"
           :query (query
                         "issuer_cik" issuer-cik
                         "issuer_cik.any_of" issuer-cik.any-of
                         "owner_cik" owner-cik
                         "owner_cik.any_of" owner-cik.any-of
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "form_type" form-type
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "transaction_code" transaction-code
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-v-x-index (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     form-type
     form-type.any-of
     form-type.gt
     form-type.gte
     form-type.lt
     form-type.lte
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/vX/index
get_stocks_filings_vX_index. SEC EDGAR master index providing metadata for all SEC filings including form types, filing dates, and direct links to source documents. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/vX/index"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "form_type" form-type
                         "form_type.any_of" form-type.any-of
                         "form_type.gt" form-type.gt
                         "form_type.gte" form-type.gte
                         "form_type.lt" form-type.lt
                         "form_type.lte" form-type.lte
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-filings-v-x-risk-factors (&key
     filing-date
     filing-date.any-of
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/filings/vX/risk-factors
get_stocks_filings_vX_risk-factors. The risk factors identified in companies' 10K filings. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/filings/vX/risk-factors"
           :query (query
                         "filing_date" filing-date
                         "filing_date.any_of" filing-date.any-of
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-financials-v1-balance-sheets (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     tickers
     tickers.all-of
     tickers.any-of
     period-end
     period-end.gt
     period-end.gte
     period-end.lt
     period-end.lte
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     fiscal-year
     fiscal-year.gt
     fiscal-year.gte
     fiscal-year.lt
     fiscal-year.lte
     fiscal-quarter
     fiscal-quarter.gt
     fiscal-quarter.gte
     fiscal-quarter.lt
     fiscal-quarter.lte
     timeframe
     timeframe.any-of
     timeframe.gt
     timeframe.gte
     timeframe.lt
     timeframe.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/financials/v1/balance-sheets
get_stocks_financials_v1_balance-sheets. A comprehensive financial dataset containing quarterly and annual balance sheet data for public companies. Includes detailed asset, liability, and equity positions representing the company's financial position at specific points in time. Balance sheet data represents... Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/financials/v1/balance-sheets"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "period_end" period-end
                         "period_end.gt" period-end.gt
                         "period_end.gte" period-end.gte
                         "period_end.lt" period-end.lt
                         "period_end.lte" period-end.lte
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "fiscal_year" fiscal-year
                         "fiscal_year.gt" fiscal-year.gt
                         "fiscal_year.gte" fiscal-year.gte
                         "fiscal_year.lt" fiscal-year.lt
                         "fiscal_year.lte" fiscal-year.lte
                         "fiscal_quarter" fiscal-quarter
                         "fiscal_quarter.gt" fiscal-quarter.gt
                         "fiscal_quarter.gte" fiscal-quarter.gte
                         "fiscal_quarter.lt" fiscal-quarter.lt
                         "fiscal_quarter.lte" fiscal-quarter.lte
                         "timeframe" timeframe
                         "timeframe.any_of" timeframe.any-of
                         "timeframe.gt" timeframe.gt
                         "timeframe.gte" timeframe.gte
                         "timeframe.lt" timeframe.lt
                         "timeframe.lte" timeframe.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-financials-v1-cash-flow-statements (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     period-end
     period-end.gt
     period-end.gte
     period-end.lt
     period-end.lte
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     tickers
     tickers.all-of
     tickers.any-of
     fiscal-year
     fiscal-year.gt
     fiscal-year.gte
     fiscal-year.lt
     fiscal-year.lte
     fiscal-quarter
     fiscal-quarter.gt
     fiscal-quarter.gte
     fiscal-quarter.lt
     fiscal-quarter.lte
     timeframe
     timeframe.any-of
     timeframe.gt
     timeframe.gte
     timeframe.lt
     timeframe.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/financials/v1/cash-flow-statements
get_stocks_financials_v1_cash-flow-statements. A comprehensive financial dataset containing quarterly, annual, and trailing twelve-month cash flow statement data for public companies. Includes detailed operating, investing, and financing cash flows with proper TTM calculations that sum all cash flow components over four... Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/financials/v1/cash-flow-statements"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "period_end" period-end
                         "period_end.gt" period-end.gt
                         "period_end.gte" period-end.gte
                         "period_end.lt" period-end.lt
                         "period_end.lte" period-end.lte
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "fiscal_year" fiscal-year
                         "fiscal_year.gt" fiscal-year.gt
                         "fiscal_year.gte" fiscal-year.gte
                         "fiscal_year.lt" fiscal-year.lt
                         "fiscal_year.lte" fiscal-year.lte
                         "fiscal_quarter" fiscal-quarter
                         "fiscal_quarter.gt" fiscal-quarter.gt
                         "fiscal_quarter.gte" fiscal-quarter.gte
                         "fiscal_quarter.lt" fiscal-quarter.lt
                         "fiscal_quarter.lte" fiscal-quarter.lte
                         "timeframe" timeframe
                         "timeframe.any_of" timeframe.any-of
                         "timeframe.gt" timeframe.gt
                         "timeframe.gte" timeframe.gte
                         "timeframe.lt" timeframe.lt
                         "timeframe.lte" timeframe.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-financials-v1-income-statements (&key
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     tickers
     tickers.all-of
     tickers.any-of
     period-end
     period-end.gt
     period-end.gte
     period-end.lt
     period-end.lte
     filing-date
     filing-date.gt
     filing-date.gte
     filing-date.lt
     filing-date.lte
     fiscal-year
     fiscal-year.gt
     fiscal-year.gte
     fiscal-year.lt
     fiscal-year.lte
     fiscal-quarter
     fiscal-quarter.gt
     fiscal-quarter.gte
     fiscal-quarter.lt
     fiscal-quarter.lte
     timeframe
     timeframe.any-of
     timeframe.gt
     timeframe.gte
     timeframe.lt
     timeframe.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/financials/v1/income-statements
get_stocks_financials_v1_income-statements. A comprehensive database of income statement financial data for public companies, including key metrics such as revenue, expenses, and net income for various reporting periods. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/financials/v1/income-statements"
           :query (query
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "tickers" (canonicalize-ticker tickers)
                         "tickers.all_of" (canonicalize-ticker tickers.all-of)
                         "tickers.any_of" (canonicalize-ticker tickers.any-of)
                         "period_end" period-end
                         "period_end.gt" period-end.gt
                         "period_end.gte" period-end.gte
                         "period_end.lt" period-end.lt
                         "period_end.lte" period-end.lte
                         "filing_date" filing-date
                         "filing_date.gt" filing-date.gt
                         "filing_date.gte" filing-date.gte
                         "filing_date.lt" filing-date.lt
                         "filing_date.lte" filing-date.lte
                         "fiscal_year" fiscal-year
                         "fiscal_year.gt" fiscal-year.gt
                         "fiscal_year.gte" fiscal-year.gte
                         "fiscal_year.lt" fiscal-year.lt
                         "fiscal_year.lte" fiscal-year.lte
                         "fiscal_quarter" fiscal-quarter
                         "fiscal_quarter.gt" fiscal-quarter.gt
                         "fiscal_quarter.gte" fiscal-quarter.gte
                         "fiscal_quarter.lt" fiscal-quarter.lt
                         "fiscal_quarter.lte" fiscal-quarter.lte
                         "timeframe" timeframe
                         "timeframe.any_of" timeframe.any-of
                         "timeframe.gt" timeframe.gt
                         "timeframe.gte" timeframe.gte
                         "timeframe.lt" timeframe.lt
                         "timeframe.lte" timeframe.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-financials-v1-ratios (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     cik
     cik.any-of
     cik.gt
     cik.gte
     cik.lt
     cik.lte
     price
     price.gt
     price.gte
     price.lt
     price.lte
     average-volume
     average-volume.gt
     average-volume.gte
     average-volume.lt
     average-volume.lte
     market-cap
     market-cap.gt
     market-cap.gte
     market-cap.lt
     market-cap.lte
     earnings-per-share
     earnings-per-share.gt
     earnings-per-share.gte
     earnings-per-share.lt
     earnings-per-share.lte
     price-to-earnings
     price-to-earnings.gt
     price-to-earnings.gte
     price-to-earnings.lt
     price-to-earnings.lte
     price-to-book
     price-to-book.gt
     price-to-book.gte
     price-to-book.lt
     price-to-book.lte
     price-to-sales
     price-to-sales.gt
     price-to-sales.gte
     price-to-sales.lt
     price-to-sales.lte
     price-to-cash-flow
     price-to-cash-flow.gt
     price-to-cash-flow.gte
     price-to-cash-flow.lt
     price-to-cash-flow.lte
     price-to-free-cash-flow
     price-to-free-cash-flow.gt
     price-to-free-cash-flow.gte
     price-to-free-cash-flow.lt
     price-to-free-cash-flow.lte
     dividend-yield
     dividend-yield.gt
     dividend-yield.gte
     dividend-yield.lt
     dividend-yield.lte
     return-on-assets
     return-on-assets.gt
     return-on-assets.gte
     return-on-assets.lt
     return-on-assets.lte
     return-on-equity
     return-on-equity.gt
     return-on-equity.gte
     return-on-equity.lt
     return-on-equity.lte
     debt-to-equity
     debt-to-equity.gt
     debt-to-equity.gte
     debt-to-equity.lt
     debt-to-equity.lte
     current
     current.gt
     current.gte
     current.lt
     current.lte
     quick
     quick.gt
     quick.gte
     quick.lt
     quick.lte
     cash
     cash.gt
     cash.gte
     cash.lt
     cash.lte
     ev-to-sales
     ev-to-sales.gt
     ev-to-sales.gte
     ev-to-sales.lt
     ev-to-sales.lte
     ev-to-ebitda
     ev-to-ebitda.gt
     ev-to-ebitda.gte
     ev-to-ebitda.lt
     ev-to-ebitda.lte
     enterprise-value
     enterprise-value.gt
     enterprise-value.gte
     enterprise-value.lt
     enterprise-value.lte
     free-cash-flow
     free-cash-flow.gt
     free-cash-flow.gte
     free-cash-flow.lt
     free-cash-flow.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/financials/v1/ratios
get_stocks_financials_v1_ratios. A comprehensive financial ratios dataset providing key valuation, profitability, liquidity, and leverage metrics for public companies. Combines data from income statements, balance sheets, and cash flow statements with daily stock prices to calculate ratios on a daily basis.... Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/financials/v1/ratios"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "cik" cik
                         "cik.any_of" cik.any-of
                         "cik.gt" cik.gt
                         "cik.gte" cik.gte
                         "cik.lt" cik.lt
                         "cik.lte" cik.lte
                         "price" price
                         "price.gt" price.gt
                         "price.gte" price.gte
                         "price.lt" price.lt
                         "price.lte" price.lte
                         "average_volume" average-volume
                         "average_volume.gt" average-volume.gt
                         "average_volume.gte" average-volume.gte
                         "average_volume.lt" average-volume.lt
                         "average_volume.lte" average-volume.lte
                         "market_cap" market-cap
                         "market_cap.gt" market-cap.gt
                         "market_cap.gte" market-cap.gte
                         "market_cap.lt" market-cap.lt
                         "market_cap.lte" market-cap.lte
                         "earnings_per_share" earnings-per-share
                         "earnings_per_share.gt" earnings-per-share.gt
                         "earnings_per_share.gte" earnings-per-share.gte
                         "earnings_per_share.lt" earnings-per-share.lt
                         "earnings_per_share.lte" earnings-per-share.lte
                         "price_to_earnings" price-to-earnings
                         "price_to_earnings.gt" price-to-earnings.gt
                         "price_to_earnings.gte" price-to-earnings.gte
                         "price_to_earnings.lt" price-to-earnings.lt
                         "price_to_earnings.lte" price-to-earnings.lte
                         "price_to_book" price-to-book
                         "price_to_book.gt" price-to-book.gt
                         "price_to_book.gte" price-to-book.gte
                         "price_to_book.lt" price-to-book.lt
                         "price_to_book.lte" price-to-book.lte
                         "price_to_sales" price-to-sales
                         "price_to_sales.gt" price-to-sales.gt
                         "price_to_sales.gte" price-to-sales.gte
                         "price_to_sales.lt" price-to-sales.lt
                         "price_to_sales.lte" price-to-sales.lte
                         "price_to_cash_flow" price-to-cash-flow
                         "price_to_cash_flow.gt" price-to-cash-flow.gt
                         "price_to_cash_flow.gte" price-to-cash-flow.gte
                         "price_to_cash_flow.lt" price-to-cash-flow.lt
                         "price_to_cash_flow.lte" price-to-cash-flow.lte
                         "price_to_free_cash_flow" price-to-free-cash-flow
                         "price_to_free_cash_flow.gt" price-to-free-cash-flow.gt
                         "price_to_free_cash_flow.gte" price-to-free-cash-flow.gte
                         "price_to_free_cash_flow.lt" price-to-free-cash-flow.lt
                         "price_to_free_cash_flow.lte" price-to-free-cash-flow.lte
                         "dividend_yield" dividend-yield
                         "dividend_yield.gt" dividend-yield.gt
                         "dividend_yield.gte" dividend-yield.gte
                         "dividend_yield.lt" dividend-yield.lt
                         "dividend_yield.lte" dividend-yield.lte
                         "return_on_assets" return-on-assets
                         "return_on_assets.gt" return-on-assets.gt
                         "return_on_assets.gte" return-on-assets.gte
                         "return_on_assets.lt" return-on-assets.lt
                         "return_on_assets.lte" return-on-assets.lte
                         "return_on_equity" return-on-equity
                         "return_on_equity.gt" return-on-equity.gt
                         "return_on_equity.gte" return-on-equity.gte
                         "return_on_equity.lt" return-on-equity.lt
                         "return_on_equity.lte" return-on-equity.lte
                         "debt_to_equity" debt-to-equity
                         "debt_to_equity.gt" debt-to-equity.gt
                         "debt_to_equity.gte" debt-to-equity.gte
                         "debt_to_equity.lt" debt-to-equity.lt
                         "debt_to_equity.lte" debt-to-equity.lte
                         "current" current
                         "current.gt" current.gt
                         "current.gte" current.gte
                         "current.lt" current.lt
                         "current.lte" current.lte
                         "quick" quick
                         "quick.gt" quick.gt
                         "quick.gte" quick.gte
                         "quick.lt" quick.lt
                         "quick.lte" quick.lte
                         "cash" cash
                         "cash.gt" cash.gt
                         "cash.gte" cash.gte
                         "cash.lt" cash.lt
                         "cash.lte" cash.lte
                         "ev_to_sales" ev-to-sales
                         "ev_to_sales.gt" ev-to-sales.gt
                         "ev_to_sales.gte" ev-to-sales.gte
                         "ev_to_sales.lt" ev-to-sales.lt
                         "ev_to_sales.lte" ev-to-sales.lte
                         "ev_to_ebitda" ev-to-ebitda
                         "ev_to_ebitda.gt" ev-to-ebitda.gt
                         "ev_to_ebitda.gte" ev-to-ebitda.gte
                         "ev_to_ebitda.lt" ev-to-ebitda.lt
                         "ev_to_ebitda.lte" ev-to-ebitda.lte
                         "enterprise_value" enterprise-value
                         "enterprise_value.gt" enterprise-value.gt
                         "enterprise_value.gte" enterprise-value.gte
                         "enterprise_value.lt" enterprise-value.lt
                         "enterprise_value.lte" enterprise-value.lte
                         "free_cash_flow" free-cash-flow
                         "free_cash_flow.gt" free-cash-flow.gt
                         "free_cash_flow.gte" free-cash-flow.gte
                         "free_cash_flow.lt" free-cash-flow.lt
                         "free_cash_flow.lte" free-cash-flow.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-taxonomies-v-x-disclosures (&key
     taxonomy
     taxonomy.any-of
     taxonomy.gt
     taxonomy.gte
     taxonomy.lt
     taxonomy.lte
     primary-category
     primary-category.any-of
     primary-category.gt
     primary-category.gte
     primary-category.lt
     primary-category.lte
     secondary-category
     secondary-category.any-of
     secondary-category.gt
     secondary-category.gte
     secondary-category.lt
     secondary-category.lte
     tertiary-category
     tertiary-category.any-of
     tertiary-category.gt
     tertiary-category.gte
     tertiary-category.lt
     tertiary-category.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/taxonomies/vX/disclosures
get_stocks_taxonomies_vX_disclosures. The complete list of 8-K disclosure classifications used in the 8-K disclosures endpoint. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/taxonomies/vX/disclosures"
           :query (query
                         "taxonomy" taxonomy
                         "taxonomy.any_of" taxonomy.any-of
                         "taxonomy.gt" taxonomy.gt
                         "taxonomy.gte" taxonomy.gte
                         "taxonomy.lt" taxonomy.lt
                         "taxonomy.lte" taxonomy.lte
                         "primary_category" primary-category
                         "primary_category.any_of" primary-category.any-of
                         "primary_category.gt" primary-category.gt
                         "primary_category.gte" primary-category.gte
                         "primary_category.lt" primary-category.lt
                         "primary_category.lte" primary-category.lte
                         "secondary_category" secondary-category
                         "secondary_category.any_of" secondary-category.any-of
                         "secondary_category.gt" secondary-category.gt
                         "secondary_category.gte" secondary-category.gte
                         "secondary_category.lt" secondary-category.lt
                         "secondary_category.lte" secondary-category.lte
                         "tertiary_category" tertiary-category
                         "tertiary_category.any_of" tertiary-category.any-of
                         "tertiary_category.gt" tertiary-category.gt
                         "tertiary_category.gte" tertiary-category.gte
                         "tertiary_category.lt" tertiary-category.lt
                         "tertiary_category.lte" tertiary-category.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-taxonomies-v-x-risk-factors (&key
     taxonomy
     taxonomy.gt
     taxonomy.gte
     taxonomy.lt
     taxonomy.lte
     primary-category
     primary-category.any-of
     primary-category.gt
     primary-category.gte
     primary-category.lt
     primary-category.lte
     secondary-category
     secondary-category.any-of
     secondary-category.gt
     secondary-category.gte
     secondary-category.lt
     secondary-category.lte
     tertiary-category
     tertiary-category.any-of
     tertiary-category.gt
     tertiary-category.gte
     tertiary-category.lt
     tertiary-category.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/taxonomies/vX/risk-factors
get_stocks_taxonomies_vX_risk-factors. The complete list of risk factor classifications used in the risk factors endpoint. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/taxonomies/vX/risk-factors"
           :query (query
                         "taxonomy" taxonomy
                         "taxonomy.gt" taxonomy.gt
                         "taxonomy.gte" taxonomy.gte
                         "taxonomy.lt" taxonomy.lt
                         "taxonomy.lte" taxonomy.lte
                         "primary_category" primary-category
                         "primary_category.any_of" primary-category.any-of
                         "primary_category.gt" primary-category.gt
                         "primary_category.gte" primary-category.gte
                         "primary_category.lt" primary-category.lt
                         "primary_category.lte" primary-category.lte
                         "secondary_category" secondary-category
                         "secondary_category.any_of" secondary-category.any-of
                         "secondary_category.gt" secondary-category.gt
                         "secondary_category.gte" secondary-category.gte
                         "secondary_category.lt" secondary-category.lt
                         "secondary_category.lte" secondary-category.lte
                         "tertiary_category" tertiary-category
                         "tertiary_category.any_of" tertiary-category.any-of
                         "tertiary_category.gt" tertiary-category.gt
                         "tertiary_category.gte" tertiary-category.gte
                         "tertiary_category.lt" tertiary-category.lt
                         "tertiary_category.lte" tertiary-category.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v1-dividends (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     ex-dividend-date
     ex-dividend-date.gt
     ex-dividend-date.gte
     ex-dividend-date.lt
     ex-dividend-date.lte
     frequency
     frequency.gt
     frequency.gte
     frequency.lt
     frequency.lte
     distribution-type
     distribution-type.any-of
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/v1/dividends
get_stocks_v1_dividends. Contains historical dividend payment records for US stocks with split-adjusted amounts and historical adjustment factors for price normalization. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/v1/dividends"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ex_dividend_date" ex-dividend-date
                         "ex_dividend_date.gt" ex-dividend-date.gt
                         "ex_dividend_date.gte" ex-dividend-date.gte
                         "ex_dividend_date.lt" ex-dividend-date.lt
                         "ex_dividend_date.lte" ex-dividend-date.lte
                         "frequency" frequency
                         "frequency.gt" frequency.gt
                         "frequency.gte" frequency.gte
                         "frequency.lt" frequency.lt
                         "frequency.lte" frequency.lte
                         "distribution_type" distribution-type
                         "distribution_type.any_of" distribution-type.any-of
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v1-exchanges (&key limit (follow nil) (max-pages *max-pages*) (cache t))
  "GET /stocks/v1/exchanges
get_stocks_v1_exchanges. US stock exchanges, trading venues, and reporting facilities including exchanges (NYSE, Nasdaq), Trade Reporting Facilities (TRF), Securities Information Processors (SIP), and OTC Reporting Facilities (ORF) for equity trading. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/v1/exchanges"
           :query (query
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v1-short-interest (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     days-to-cover
     days-to-cover.any-of
     days-to-cover.gt
     days-to-cover.gte
     days-to-cover.lt
     days-to-cover.lte
     settlement-date
     settlement-date.any-of
     settlement-date.gt
     settlement-date.gte
     settlement-date.lt
     settlement-date.lte
     avg-daily-volume
     avg-daily-volume.any-of
     avg-daily-volume.gt
     avg-daily-volume.gte
     avg-daily-volume.lt
     avg-daily-volume.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/v1/short-interest
get_stocks_v1_short-interest. Comprehensive FINRA short interest data that tracks the short selling metrics for securities on a specific settlement date. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/v1/short-interest"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "days_to_cover" days-to-cover
                         "days_to_cover.any_of" days-to-cover.any-of
                         "days_to_cover.gt" days-to-cover.gt
                         "days_to_cover.gte" days-to-cover.gte
                         "days_to_cover.lt" days-to-cover.lt
                         "days_to_cover.lte" days-to-cover.lte
                         "settlement_date" settlement-date
                         "settlement_date.any_of" settlement-date.any-of
                         "settlement_date.gt" settlement-date.gt
                         "settlement_date.gte" settlement-date.gte
                         "settlement_date.lt" settlement-date.lt
                         "settlement_date.lte" settlement-date.lte
                         "avg_daily_volume" avg-daily-volume
                         "avg_daily_volume.any_of" avg-daily-volume.any-of
                         "avg_daily_volume.gt" avg-daily-volume.gt
                         "avg_daily_volume.gte" avg-daily-volume.gte
                         "avg_daily_volume.lt" avg-daily-volume.lt
                         "avg_daily_volume.lte" avg-daily-volume.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v1-short-volume (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     short-volume-ratio
     short-volume-ratio.any-of
     short-volume-ratio.gt
     short-volume-ratio.gte
     short-volume-ratio.lt
     short-volume-ratio.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/v1/short-volume
get_stocks_v1_short-volume. Contains short selling volume for different stock tickers, capturing total trading volume, short sale details, and breakdown by different trading platforms. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/v1/short-volume"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "short_volume_ratio" short-volume-ratio
                         "short_volume_ratio.any_of" short-volume-ratio.any-of
                         "short_volume_ratio.gt" short-volume-ratio.gt
                         "short_volume_ratio.gte" short-volume-ratio.gte
                         "short_volume_ratio.lt" short-volume-ratio.lt
                         "short_volume_ratio.lte" short-volume-ratio.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v1-splits (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     execution-date
     execution-date.gt
     execution-date.gte
     execution-date.lt
     execution-date.lte
     adjustment-type
     adjustment-type.any-of
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/v1/splits
get_stocks_v1_splits. Contains historical stock split and reverse split events for US equities with historical adjustment factors for price normalization. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/v1/splits"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "execution_date" execution-date
                         "execution_date.gt" execution-date.gt
                         "execution_date.gte" execution-date.gte
                         "execution_date.lt" execution-date.lt
                         "execution_date.lte" execution-date.lte
                         "adjustment_type" adjustment-type
                         "adjustment_type.any_of" adjustment-type.any-of
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stocks-v-x-float (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     free-float-percent
     free-float-percent.gt
     free-float-percent.gte
     free-float-percent.lt
     free-float-percent.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /stocks/vX/float
get_stocks_vX_float. Contains free float data for US-listed securities, showing the most recent available number of shares available for public trading and the percentage of total shares outstanding. Pass :FOLLOW T to walk next_url."
  (api-get "/stocks/vX/float"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "free_float_percent" free-float-percent
                         "free_float_percent.gt" free-float-percent.gt
                         "free_float_percent.gte" free-float-percent.gte
                         "free_float_percent.lt" free-float-percent.lt
                         "free_float_percent.lte" free-float-percent.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-tmx-v1-corporate-events (&key
     date
     date.any-of
     date.gt
     date.gte
     date.lt
     date.lte
     type
     type.any-of
     type.gt
     type.gte
     type.lt
     type.lte
     status
     status.any-of
     status.gt
     status.gte
     status.lt
     status.lte
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     isin
     isin.any-of
     isin.gt
     isin.gte
     isin.lt
     isin.lte
     trading-venue
     trading-venue.any-of
     trading-venue.gt
     trading-venue.gte
     trading-venue.lt
     trading-venue.lte
     tmx-company-id
     tmx-company-id.gt
     tmx-company-id.gte
     tmx-company-id.lt
     tmx-company-id.lte
     tmx-record-id
     tmx-record-id.any-of
     tmx-record-id.gt
     tmx-record-id.gte
     tmx-record-id.lt
     tmx-record-id.lte
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /tmx/v1/corporate-events
get_tmx_v1_corporate-events. Contains corporate events and announcements for publicly traded companies, including earnings releases, conferences, dividends, and business updates sourced from TMX. Pass :FOLLOW T to walk next_url."
  (api-get "/tmx/v1/corporate-events"
           :query (query
                         "date" date
                         "date.any_of" date.any-of
                         "date.gt" date.gt
                         "date.gte" date.gte
                         "date.lt" date.lt
                         "date.lte" date.lte
                         "type" type
                         "type.any_of" type.any-of
                         "type.gt" type.gt
                         "type.gte" type.gte
                         "type.lt" type.lt
                         "type.lte" type.lte
                         "status" status
                         "status.any_of" status.any-of
                         "status.gt" status.gt
                         "status.gte" status.gte
                         "status.lt" status.lt
                         "status.lte" status.lte
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "isin" isin
                         "isin.any_of" isin.any-of
                         "isin.gt" isin.gt
                         "isin.gte" isin.gte
                         "isin.lt" isin.lt
                         "isin.lte" isin.lte
                         "trading_venue" trading-venue
                         "trading_venue.any_of" trading-venue.any-of
                         "trading_venue.gt" trading-venue.gt
                         "trading_venue.gte" trading-venue.gte
                         "trading_venue.lt" trading-venue.lt
                         "trading_venue.lte" trading-venue.lte
                         "tmx_company_id" tmx-company-id
                         "tmx_company_id.gt" tmx-company-id.gt
                         "tmx_company_id.gte" tmx-company-id.gte
                         "tmx_company_id.lt" tmx-company-id.lt
                         "tmx_company_id.lte" tmx-company-id.lte
                         "tmx_record_id" tmx-record-id
                         "tmx_record_id.any_of" tmx-record-id.any-of
                         "tmx_record_id.gt" tmx-record-id.gt
                         "tmx_record_id.gte" tmx-record-id.gte
                         "tmx_record_id.lt" tmx-record-id.lt
                         "tmx_record_id.lte" tmx-record-id.lte
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-real-time-currency-conversion (from to &key amount precision (cache nil))
  "GET /v1/conversion/{from}/{to}
RealTimeCurrencyConversion. Get currency conversions using the latest market conversion rates. Note than you can convert in both directions. For example USD to CAD or CAD to USD."
  (api-get (format nil "/v1/conversion/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to))
           :query (query
                         "amount" amount
                         "precision" precision
)
           :cache cache))

(defun get-deprecated-historic-crypto-trades (from to date &key offset limit (cache t))
  "GET /v1/historic/crypto/{from}/{to}/{date}
DeprecatedGetHistoricCryptoTrades. Deprecated. Get historic trade ticks for a cryptocurrency pair."
  (api-get (format nil "/v1/historic/crypto/~A/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to)
                   (path-segment date))
           :query (query
                         "offset" offset
                         "limit" limit
)
           :cache cache))

(defun get-deprecated-historic-forex-quotes (from to date &key offset limit (cache t))
  "GET /v1/historic/forex/{from}/{to}/{date}
DeprecatedGetHistoricForexQuotes. Deprecated. Get historic ticks for a forex currency pair."
  (api-get (format nil "/v1/historic/forex/~A/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to)
                   (path-segment date))
           :query (query
                         "offset" offset
                         "limit" limit
)
           :cache cache))

(defun get-crypto-ema (crypto-ticker
    &key
     timestamp
     timespan
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/ema/{cryptoTicker}
CryptoEMA. Get the exponential moving average (EMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/ema/~A"
                   (ticker-segment crypto-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-forex-ema (fx-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/ema/{fxTicker}
ForexEMA. Get the exponential moving average (EMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/ema/~A"
                   (ticker-segment fx-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-indices-ema (indices-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/ema/{indicesTicker}
IndicesEMA. Get the exponential moving average (EMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/ema/~A"
                   (ticker-segment indices-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-ema (options-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/ema/{optionsTicker}
OptionsEMA. Get the exponential moving average (EMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/ema/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-ema (stock-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/ema/{stockTicker}
EMA. Get the exponential moving average (EMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/ema/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-crypto-macd (crypto-ticker
    &key
     timestamp
     timespan
     short-window
     long-window
     signal-window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/macd/{cryptoTicker}
CryptoMACD. Moving Average Convergence/Divergence (MACD) Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/macd/~A"
                   (ticker-segment crypto-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "short_window" short-window
                         "long_window" long-window
                         "signal_window" signal-window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-forex-macd (fx-ticker
    &key
     timestamp
     timespan
     adjusted
     short-window
     long-window
     signal-window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/macd/{fxTicker}
ForexMACD. Moving Average Convergence/Divergence (MACD) Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/macd/~A"
                   (ticker-segment fx-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "short_window" short-window
                         "long_window" long-window
                         "signal_window" signal-window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-indices-macd (indices-ticker
    &key
     timestamp
     timespan
     adjusted
     short-window
     long-window
     signal-window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/macd/{indicesTicker}
IndicesMACD. Moving Average Convergence/Divergence (MACD) Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/macd/~A"
                   (ticker-segment indices-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "short_window" short-window
                         "long_window" long-window
                         "signal_window" signal-window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-macd (options-ticker
    &key
     timestamp
     timespan
     adjusted
     short-window
     long-window
     signal-window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/macd/{optionsTicker}
OptionsMACD. Moving Average Convergence/Divergence (MACD) Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/macd/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "short_window" short-window
                         "long_window" long-window
                         "signal_window" signal-window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-macd (stock-ticker
    &key
     timestamp
     timespan
     adjusted
     short-window
     long-window
     signal-window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/macd/{stockTicker}
MACD. Moving Average Convergence/Divergence (MACD) Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/macd/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "short_window" short-window
                         "long_window" long-window
                         "signal_window" signal-window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-crypto-rsi (crypto-ticker
    &key
     timestamp
     timespan
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/rsi/{cryptoTicker}
CryptoRSI. Get the relative strength index (RSI) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/rsi/~A"
                   (ticker-segment crypto-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-forex-rsi (fx-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/rsi/{fxTicker}
ForexRSI. Get the relative strength index (RSI) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/rsi/~A"
                   (ticker-segment fx-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-indices-rsi (indices-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/rsi/{indicesTicker}
IndicesRSI. Get the relative strength index (RSI) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/rsi/~A"
                   (ticker-segment indices-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-rsi (options-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/rsi/{optionsTicker}
OptionsRSI. Get the relative strength index (RSI) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/rsi/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-rsi (stock-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/rsi/{stockTicker}
RSI. Get the relative strength index (RSI) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/rsi/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-crypto-sma (crypto-ticker
    &key
     timestamp
     timespan
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/sma/{cryptoTicker}
CryptoSMA. Get the simple moving average (SMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/sma/~A"
                   (ticker-segment crypto-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-forex-sma (fx-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/sma/{fxTicker}
ForexSMA. Get the simple moving average (SMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/sma/~A"
                   (ticker-segment fx-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-indices-sma (indices-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/sma/{indicesTicker}
IndicesSMA. Get the simple moving average (SMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/sma/~A"
                   (ticker-segment indices-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-sma (options-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/sma/{optionsTicker}
OptionsSMA. Get the simple moving average (SMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/sma/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-sma (stock-ticker
    &key
     timestamp
     timespan
     adjusted
     window
     series-type
     expand-underlying
     order
     limit
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/indicators/sma/{stockTicker}
SMA. Get the simple moving average (SMA) for a ticker symbol over a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/indicators/sma/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timespan" timespan
                         "adjusted" adjusted
                         "window" window
                         "series_type" series-type
                         "expand_underlying" expand-underlying
                         "order" order
                         "limit" limit
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-last-trade-crypto (from to &key (cache nil))
  "GET /v1/last/crypto/{from}/{to}
LastTradeCrypto. Get the last trade tick for a cryptocurrency pair."
  (api-get (format nil "/v1/last/crypto/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to))
           :cache cache))

(defun get-last-quote-currencies (from to &key (cache nil))
  "GET /v1/last_quote/currencies/{from}/{to}
LastQuoteCurrencies. Get the last quote tick for a forex currency pair."
  (api-get (format nil "/v1/last_quote/currencies/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to))
           :cache cache))

(defun get-market-status (&key (cache nil))
  "GET /v1/marketstatus/now
GetMarketStatus. Get the current trading status of the exchanges and overall financial markets."
  (api-get "/v1/marketstatus/now"
           :cache cache))

(defun get-market-holidays (&key (cache t))
  "GET /v1/marketstatus/upcoming
GetMarketHolidays. Get upcoming market holidays and their open/close times."
  (api-get "/v1/marketstatus/upcoming"
           :cache cache))

(defun get-crypto-open-close (from to date &key adjusted (cache nil))
  "GET /v1/open-close/crypto/{from}/{to}/{date}
GetCryptoOpenClose. Get the open, close prices of a cryptocurrency symbol on a certain day."
  (api-get (format nil "/v1/open-close/crypto/~A/~A/~A"
                   (ticker-segment from)
                   (ticker-segment to)
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-indices-open-close (indices-ticker date &key (cache nil))
  "GET /v1/open-close/{indicesTicker}/{date}
GetIndicesOpenClose. Get the open, close and afterhours values of a index symbol on a certain date."
  (api-get (format nil "/v1/open-close/~A/~A"
                   (ticker-segment indices-ticker)
                   (path-segment date))
           :cache cache))

(defun get-options-open-close (options-ticker date &key adjusted (cache nil))
  "GET /v1/open-close/{optionsTicker}/{date}
GetOptionsOpenClose. Get the open, close and afterhours prices of an options contract on a certain date."
  (api-get (format nil "/v1/open-close/~A/~A"
                   (ticker-segment options-ticker)
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-stocks-open-close (stocks-ticker date &key adjusted (cache nil))
  "GET /v1/open-close/{stocksTicker}/{date}
GetStocksOpenClose. Get the open, close and afterhours prices of a stock symbol on a certain date."
  (api-get (format nil "/v1/open-close/~A/~A"
                   (ticker-segment stocks-ticker)
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-v1-reference-ipos (&key
     ticker
     ticker.any-of
     ticker.gt
     ticker.gte
     ticker.lt
     ticker.lte
     us-code
     us-code.any-of
     us-code.gt
     us-code.gte
     us-code.lt
     us-code.lte
     isin
     isin.any-of
     isin.gt
     isin.gte
     isin.lt
     isin.lte
     listing-date
     listing-date.gt
     listing-date.gte
     listing-date.lt
     listing-date.lte
     ipo-status
     ipo-status.any-of
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/reference/ipos
get_v1_reference_ipos. Contains comprehensive data about Initial Public Offerings (IPOs) and direct listings for US stocks, tracking both historical and pending offerings with detailed pricing, share, and timing information. Pass :FOLLOW T to walk next_url."
  (api-get "/v1/reference/ipos"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "us_code" us-code
                         "us_code.any_of" us-code.any-of
                         "us_code.gt" us-code.gt
                         "us_code.gte" us-code.gte
                         "us_code.lt" us-code.lt
                         "us_code.lte" us-code.lte
                         "isin" isin
                         "isin.any_of" isin.any-of
                         "isin.gt" isin.gt
                         "isin.gte" isin.gte
                         "isin.lt" isin.lt
                         "isin.lte" isin.lte
                         "listing_date" listing-date
                         "listing_date.gt" listing-date.gt
                         "listing_date.gte" listing-date.gte
                         "listing_date.lt" listing-date.lt
                         "listing_date.lte" listing-date.lte
                         "ipo_status" ipo-status
                         "ipo_status.any_of" ipo-status.any-of
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-filings (&key
     type
     filing-date
     period-of-report-date
     has-xbrl
     entities.company-data.name
     entities.company-data.cik
     entities.company-data.ticker
     entities.company-data.sic
     filing-date.gte
     filing-date.gt
     filing-date.lte
     filing-date.lt
     period-of-report-date.gte
     period-of-report-date.gt
     period-of-report-date.lte
     period-of-report-date.lt
     entities.company-data.name.search
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/reference/sec/filings
ListFilings. List filings Pass :FOLLOW T to walk next_url."
  (api-get "/v1/reference/sec/filings"
           :query (query
                         "type" type
                         "filing_date" filing-date
                         "period_of_report_date" period-of-report-date
                         "has_xbrl" has-xbrl
                         "entities.company_data.name" entities.company-data.name
                         "entities.company_data.cik" entities.company-data.cik
                         "entities.company_data.ticker" entities.company-data.ticker
                         "entities.company_data.sic" entities.company-data.sic
                         "filing_date.gte" filing-date.gte
                         "filing_date.gt" filing-date.gt
                         "filing_date.lte" filing-date.lte
                         "filing_date.lt" filing-date.lt
                         "period_of_report_date.gte" period-of-report-date.gte
                         "period_of_report_date.gt" period-of-report-date.gt
                         "period_of_report_date.lte" period-of-report-date.lte
                         "period_of_report_date.lt" period-of-report-date.lt
                         "entities.company_data.name.search" entities.company-data.name.search
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-filing (filing-id &key (cache t))
  "GET /v1/reference/sec/filings/{filing_id}
GetFiling. Get filing"
  (api-get (format nil "/v1/reference/sec/filings/~A"
                   (path-segment filing-id))
           :cache cache))

(defun list-filing-files (filing-id
    &key
     sequence
     filename
     sequence.gte
     sequence.gt
     sequence.lte
     sequence.lt
     filename.gte
     filename.gt
     filename.lte
     filename.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v1/reference/sec/filings/{filing_id}/files
ListFilingFiles. List filing files Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v1/reference/sec/filings/~A/files"
                   (path-segment filing-id))
           :query (query
                         "sequence" sequence
                         "filename" filename
                         "sequence.gte" sequence.gte
                         "sequence.gt" sequence.gt
                         "sequence.lte" sequence.lte
                         "sequence.lt" sequence.lt
                         "filename.gte" filename.gte
                         "filename.gt" filename.gt
                         "filename.lte" filename.lte
                         "filename.lt" filename.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-filing-file (filing-id file-id &key (cache t))
  "GET /v1/reference/sec/filings/{filing_id}/files/{file_id}
GetFilingFile. Get filing file"
  (api-get (format nil "/v1/reference/sec/filings/~A/files/~A"
                   (path-segment filing-id)
                   (path-segment file-id))
           :cache cache))

(defun get-related-companies (ticker &key (cache t))
  "GET /v1/related-companies/{ticker}
GetRelatedCompanies. Get a list of tickers related to the queried ticker based on News and Returns data."
  (api-get (format nil "/v1/related-companies/~A"
                   (ticker-segment ticker))
           :cache cache))

(defun get-snapshot-summary (&key ticker.any-of (cache t))
  "GET /v1/summaries
SnapshotSummary. Get everything needed to visualize the tick-by-tick movement of a list of tickers."
  (api-get "/v1/summaries"
           :query (query
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
)
           :cache cache))

(defun get-grouped-crypto-aggregates (date &key adjusted (cache nil))
  "GET /v2/aggs/grouped/locale/global/market/crypto/{date}
GetGroupedCryptoAggregates. Get the daily open, high, low, and close (OHLC) for the entire cryptocurrency markets."
  (api-get (format nil "/v2/aggs/grouped/locale/global/market/crypto/~A"
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-grouped-forex-aggregates (date &key adjusted (cache nil))
  "GET /v2/aggs/grouped/locale/global/market/fx/{date}
GetGroupedForexAggregates. Get the daily open, high, low, and close (OHLC) for the entire forex markets."
  (api-get (format nil "/v2/aggs/grouped/locale/global/market/fx/~A"
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-grouped-stocks-aggregates (date &key adjusted include-otc (cache nil))
  "GET /v2/aggs/grouped/locale/us/market/stocks/{date}
GetGroupedStocksAggregates. Get the daily open, high, low, and close (OHLC) for the entire stocks/equities markets."
  (api-get (format nil "/v2/aggs/grouped/locale/us/market/stocks/~A"
                   (path-segment date))
           :query (query
                         "adjusted" adjusted
                         "include_otc" include-otc
)
           :cache cache))

(defun get-previous-crypto-aggregates (crypto-ticker &key adjusted (cache nil))
  "GET /v2/aggs/ticker/{cryptoTicker}/prev
GetPreviousCryptoAggregates. Get the previous day's open, high, low, and close (OHLC) for the specified cryptocurrency pair."
  (api-get (format nil "/v2/aggs/ticker/~A/prev"
                   (ticker-segment crypto-ticker))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-crypto-aggregates (crypto-ticker multiplier timespan from to &key adjusted sort limit (cache nil))
  "GET /v2/aggs/ticker/{cryptoTicker}/range/{multiplier}/{timespan}/{from}/{to}
GetCryptoAggregates. Get aggregate bars for a cryptocurrency pair over a given date range in custom time window sizes. For example, if timespan = ‘minute’ and multiplier = ‘5’ then 5-minute bars will be returned."
  (api-get (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                   (ticker-segment crypto-ticker)
                   (path-segment multiplier)
                   (timespan-segment timespan)
                   (path-segment from)
                   (path-segment to))
           :query (query
                         "adjusted" adjusted
                         "sort" sort
                         "limit" limit
)
           :cache cache))

(defun get-previous-forex-aggregates (forex-ticker &key adjusted (cache nil))
  "GET /v2/aggs/ticker/{forexTicker}/prev
GetPreviousForexAggregates. Get the previous day's open, high, low, and close (OHLC) for the specified forex pair."
  (api-get (format nil "/v2/aggs/ticker/~A/prev"
                   (ticker-segment forex-ticker))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-forex-aggregates (forex-ticker multiplier timespan from to &key adjusted sort limit (cache nil))
  "GET /v2/aggs/ticker/{forexTicker}/range/{multiplier}/{timespan}/{from}/{to}
GetForexAggregates. Get aggregate bars for a forex pair over a given date range in custom time window sizes. For example, if timespan = ‘minute’ and multiplier = ‘5’ then 5-minute bars will be returned."
  (api-get (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                   (ticker-segment forex-ticker)
                   (path-segment multiplier)
                   (timespan-segment timespan)
                   (path-segment from)
                   (path-segment to))
           :query (query
                         "adjusted" adjusted
                         "sort" sort
                         "limit" limit
)
           :cache cache))

(defun get-previous-indices-aggregates (indices-ticker &key (cache nil))
  "GET /v2/aggs/ticker/{indicesTicker}/prev
GetPreviousIndicesAggregates. Get the previous day's open, high, low, and close (OHLC) for the specified index."
  (api-get (format nil "/v2/aggs/ticker/~A/prev"
                   (ticker-segment indices-ticker))
           :cache cache))

(defun get-indices-aggregates (indices-ticker multiplier timespan from to &key sort limit (cache nil))
  "GET /v2/aggs/ticker/{indicesTicker}/range/{multiplier}/{timespan}/{from}/{to}
GetIndicesAggregates. Get aggregate bars for an index over a given date range in custom time window sizes. For example, if timespan = ‘minute’ and multiplier = ‘5’ then 5-minute bars will be returned."
  (api-get (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                   (ticker-segment indices-ticker)
                   (path-segment multiplier)
                   (timespan-segment timespan)
                   (path-segment from)
                   (path-segment to))
           :query (query
                         "sort" sort
                         "limit" limit
)
           :cache cache))

(defun get-previous-options-aggregates (options-ticker &key adjusted (cache nil))
  "GET /v2/aggs/ticker/{optionsTicker}/prev
GetPreviousOptionsAggregates. Get the previous day's open, high, low, and close (OHLC) for the specified option contract."
  (api-get (format nil "/v2/aggs/ticker/~A/prev"
                   (ticker-segment options-ticker))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-options-aggregates (options-ticker multiplier timespan from to &key adjusted sort limit (cache nil))
  "GET /v2/aggs/ticker/{optionsTicker}/range/{multiplier}/{timespan}/{from}/{to}
GetOptionsAggregates. Get aggregate bars for an option contract over a given date range in custom time window sizes. For example, if timespan = ‘minute’ and multiplier = ‘5’ then 5-minute bars will be returned."
  (api-get (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                   (ticker-segment options-ticker)
                   (path-segment multiplier)
                   (timespan-segment timespan)
                   (path-segment from)
                   (path-segment to))
           :query (query
                         "adjusted" adjusted
                         "sort" sort
                         "limit" limit
)
           :cache cache))

(defun get-previous-stocks-aggregates (stocks-ticker &key adjusted (cache nil))
  "GET /v2/aggs/ticker/{stocksTicker}/prev
GetPreviousStocksAggregates. Get the previous day's open, high, low, and close (OHLC) for the specified stock ticker."
  (api-get (format nil "/v2/aggs/ticker/~A/prev"
                   (ticker-segment stocks-ticker))
           :query (query
                         "adjusted" adjusted
)
           :cache cache))

(defun get-stocks-aggregates (stocks-ticker multiplier timespan from to &key adjusted sort limit (follow nil) (max-pages *max-pages*) (cache nil))
  "GET /v2/aggs/ticker/{stocksTicker}/range/{multiplier}/{timespan}/{from}/{to}
GetStocksAggregates. Get aggregate bars for a stock over a given date range in custom time window sizes. For example, if timespan = ‘minute’ and multiplier = ‘5’ then 5-minute bars will be returned. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v2/aggs/ticker/~A/range/~A/~A/~A/~A"
                   (ticker-segment stocks-ticker)
                   (path-segment multiplier)
                   (timespan-segment timespan)
                   (path-segment from)
                   (path-segment to))
           :query (query
                         "adjusted" adjusted
                         "sort" sort
                         "limit" limit
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-last-quote (stocks-ticker &key (cache nil))
  "GET /v2/last/nbbo/{stocksTicker}
LastQuote. Get the most recent NBBO (Quote) tick for a given stock."
  (api-get (format nil "/v2/last/nbbo/~A"
                   (ticker-segment stocks-ticker))
           :cache cache))

(defun get-last-trade-options (options-ticker &key (cache nil))
  "GET /v2/last/trade/{optionsTicker}
LastTradeOptions. Get the most recent trade for a given options contract."
  (api-get (format nil "/v2/last/trade/~A"
                   (ticker-segment options-ticker))
           :cache cache))

(defun get-stock-last-trade (stocks-ticker &key (cache nil))
  "GET /v2/last/trade/{stocksTicker}
LastTrade. Get the most recent trade for a given stock."
  (api-get (format nil "/v2/last/trade/~A"
                   (ticker-segment stocks-ticker))
           :cache cache))

(defun list-news (&key
     ticker
     published-utc
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     published-utc.gte
     published-utc.gt
     published-utc.lte
     published-utc.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v2/reference/news
ListNews. Get the most recent news articles relating to a stock ticker symbol, including a summary of the article and a link to the original source. Pass :FOLLOW T to walk next_url."
  (api-get "/v2/reference/news"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "published_utc" published-utc
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "published_utc.gte" published-utc.gte
                         "published_utc.gt" published-utc.gt
                         "published_utc.lte" published-utc.lte
                         "published_utc.lt" published-utc.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-crypto-snapshot-tickers (&key tickers (cache nil))
  "GET /v2/snapshot/locale/global/markets/crypto/tickers
GetCryptoSnapshotTickers. Get the current minute, day, and previous day’s aggregate, as well as the last trade and quote for all traded cryptocurrency symbols. Note: Snapshot data is cleared at 12am EST and gets populated as data is received from the exchanges. This can happen as early as 4am EST."
  (api-get "/v2/snapshot/locale/global/markets/crypto/tickers"
           :query (query
                         "tickers" (canonicalize-ticker tickers)
)
           :cache cache))

(defun get-crypto-snapshot-ticker (ticker &key (cache nil))
  "GET /v2/snapshot/locale/global/markets/crypto/tickers/{ticker}
GetCryptoSnapshotTicker. Get the current minute, day, and previous day’s aggregate, as well as the last trade and quote for a single traded cryptocurrency symbol. Note: Snapshot data is cleared at 12am EST and gets populated as data is received from the exchanges."
  (api-get (format nil "/v2/snapshot/locale/global/markets/crypto/tickers/~A"
                   (ticker-segment ticker))
           :cache cache))

(defun get-deprecated-crypto-snapshot-ticker-book (ticker &key (cache nil))
  "GET /v2/snapshot/locale/global/markets/crypto/tickers/{ticker}/book
DeprecatedGetCryptoSnapshotTickerBook. Deprecated. Get the current level 2 book of a single ticker. This is the combined book from all of the exchanges. Note: Snapshot data is cleared at 12am EST and gets populated as data is received from the exchanges."
  (api-get (format nil "/v2/snapshot/locale/global/markets/crypto/tickers/~A/book"
                   (ticker-segment ticker))
           :cache cache))

(defun get-crypto-snapshot-direction (direction &key (cache nil))
  "GET /v2/snapshot/locale/global/markets/crypto/{direction}
GetCryptoSnapshotDirection. Get the current top 20 gainers or losers of the day in cryptocurrency markets. Top gainers are those tickers whose price has increased by the highest percentage since the previous day's close. Top losers are those tickers whose price has decreased by the highest percentage..."
  (api-get (format nil "/v2/snapshot/locale/global/markets/crypto/~A"
                   (path-segment direction))
           :cache cache))

(defun get-forex-snapshot-tickers (&key tickers (cache nil))
  "GET /v2/snapshot/locale/global/markets/forex/tickers
GetForexSnapshotTickers. Get the current minute, day, and previous day’s aggregate, as well as the last trade and quote for all traded forex symbols. Note: Snapshot data is cleared at 12am EST and gets populated as data is received from the exchanges. This can happen as early as 4am EST."
  (api-get "/v2/snapshot/locale/global/markets/forex/tickers"
           :query (query
                         "tickers" (canonicalize-ticker tickers)
)
           :cache cache))

(defun get-forex-snapshot-ticker (ticker &key (cache nil))
  "GET /v2/snapshot/locale/global/markets/forex/tickers/{ticker}
GetForexSnapshotTicker. Get the current minute, day, and previous day’s aggregate, as well as the last trade and quote for a single traded currency symbol. Note: Snapshot data is cleared at 12am EST and gets populated as data is received from the exchanges."
  (api-get (format nil "/v2/snapshot/locale/global/markets/forex/tickers/~A"
                   (ticker-segment ticker))
           :cache cache))

(defun get-forex-snapshot-direction (direction &key (cache nil))
  "GET /v2/snapshot/locale/global/markets/forex/{direction}
GetForexSnapshotDirection. Get the current top 20 gainers or losers of the day in forex markets. Top gainers are those tickers whose price has increased by the highest percentage since the previous day's close. Top losers are those tickers whose price has decreased by the highest percentage since the..."
  (api-get (format nil "/v2/snapshot/locale/global/markets/forex/~A"
                   (path-segment direction))
           :cache cache))

(defun get-stocks-snapshot-tickers (&key tickers include-otc (cache nil))
  "GET /v2/snapshot/locale/us/markets/stocks/tickers
GetStocksSnapshotTickers. Get the most up-to-date market data for all traded stock symbols. Note: Snapshot data is cleared at 3:30am EST and gets populated as data is received from the exchanges. This can happen as early as 4am EST."
  (api-get "/v2/snapshot/locale/us/markets/stocks/tickers"
           :query (query
                         "tickers" (canonicalize-ticker tickers)
                         "include_otc" include-otc
)
           :cache cache))

(defun get-stocks-snapshot-ticker (stocks-ticker &key (cache nil))
  "GET /v2/snapshot/locale/us/markets/stocks/tickers/{stocksTicker}
GetStocksSnapshotTicker. Get the most up-to-date market data for a single traded stock ticker. Note: Snapshot data is cleared at 3:30am EST and gets populated as data is received from the exchanges. This can happen as early as 4am EST."
  (api-get (format nil "/v2/snapshot/locale/us/markets/stocks/tickers/~A"
                   (ticker-segment stocks-ticker))
           :cache cache))

(defun get-stocks-snapshot-direction (direction &key include-otc (cache nil))
  "GET /v2/snapshot/locale/us/markets/stocks/{direction}
GetStocksSnapshotDirection. Get the most up-to-date market data for the current top 20 gainers or losers of the day in the stocks/equities markets. Top gainers are those tickers whose price has increased by the highest percentage since the previous day's close. Top losers are those tickers whose price..."
  (api-get (format nil "/v2/snapshot/locale/us/markets/stocks/~A"
                   (path-segment direction))
           :query (query
                         "include_otc" include-otc
)
           :cache cache))

(defun get-deprecated-historic-stocks-quotes (ticker date &key timestamp timestamp-limit reverse limit (cache t))
  "GET /v2/ticks/stocks/nbbo/{ticker}/{date}
DeprecatedGetHistoricStocksQuotes. Deprecated. Get NBBO quotes for a given ticker symbol on a specified date."
  (api-get (format nil "/v2/ticks/stocks/nbbo/~A/~A"
                   (ticker-segment ticker)
                   (path-segment date))
           :query (query
                         "timestamp" timestamp
                         "timestampLimit" timestamp-limit
                         "reverse" reverse
                         "limit" limit
)
           :cache cache))

(defun get-deprecated-historic-stocks-trades (ticker date &key timestamp timestamp-limit reverse limit (cache nil))
  "GET /v2/ticks/stocks/trades/{ticker}/{date}
DeprecatedGetHistoricStocksTrades. Deprecated. Get trades for a given ticker symbol on a specified date."
  (api-get (format nil "/v2/ticks/stocks/trades/~A/~A"
                   (ticker-segment ticker)
                   (path-segment date))
           :query (query
                         "timestamp" timestamp
                         "timestampLimit" timestamp-limit
                         "reverse" reverse
                         "limit" limit
)
           :cache cache))

(defun get-quotes-fx (fx-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/quotes/{fxTicker}
QuotesFx. Get BBO quotes for a ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/quotes/~A"
                   (ticker-segment fx-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-quotes-options (options-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/quotes/{optionsTicker}
QuotesOptions. Get quotes for an options ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/quotes/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-quotes (stock-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/quotes/{stockTicker}
Quotes. Get NBBO quotes for a ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/quotes/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-conditions (&key
     asset-class
     data-type
     id
     sip
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v3/reference/conditions
ListConditions. List all conditions that Massive uses. Pass :FOLLOW T to walk next_url."
  (api-get "/v3/reference/conditions"
           :query (query
                         "asset_class" asset-class
                         "data_type" data-type
                         "id" id
                         "sip" sip
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-dividends (&key
     ticker
     ex-dividend-date
     record-date
     declaration-date
     pay-date
     frequency
     cash-amount
     dividend-type
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     ex-dividend-date.gte
     ex-dividend-date.gt
     ex-dividend-date.lte
     ex-dividend-date.lt
     record-date.gte
     record-date.gt
     record-date.lte
     record-date.lt
     declaration-date.gte
     declaration-date.gt
     declaration-date.lte
     declaration-date.lt
     pay-date.gte
     pay-date.gt
     pay-date.lte
     pay-date.lt
     cash-amount.gte
     cash-amount.gt
     cash-amount.lte
     cash-amount.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v3/reference/dividends
ListDividends. Get a list of historical cash dividends, including the ticker symbol, declaration date, ex-dividend date, record date, pay date, frequency, and amount. Pass :FOLLOW T to walk next_url."
  (api-get "/v3/reference/dividends"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "ex_dividend_date" ex-dividend-date
                         "record_date" record-date
                         "declaration_date" declaration-date
                         "pay_date" pay-date
                         "frequency" frequency
                         "cash_amount" cash-amount
                         "dividend_type" dividend-type
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ex_dividend_date.gte" ex-dividend-date.gte
                         "ex_dividend_date.gt" ex-dividend-date.gt
                         "ex_dividend_date.lte" ex-dividend-date.lte
                         "ex_dividend_date.lt" ex-dividend-date.lt
                         "record_date.gte" record-date.gte
                         "record_date.gt" record-date.gt
                         "record_date.lte" record-date.lte
                         "record_date.lt" record-date.lt
                         "declaration_date.gte" declaration-date.gte
                         "declaration_date.gt" declaration-date.gt
                         "declaration_date.lte" declaration-date.lte
                         "declaration_date.lt" declaration-date.lt
                         "pay_date.gte" pay-date.gte
                         "pay_date.gt" pay-date.gt
                         "pay_date.lte" pay-date.lte
                         "pay_date.lt" pay-date.lt
                         "cash_amount.gte" cash-amount.gte
                         "cash_amount.gt" cash-amount.gt
                         "cash_amount.lte" cash-amount.lte
                         "cash_amount.lt" cash-amount.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-exchanges (&key asset-class locale (cache t))
  "GET /v3/reference/exchanges
ListExchanges. List all exchanges that Massive knows about."
  (api-get "/v3/reference/exchanges"
           :query (query
                         "asset_class" asset-class
                         "locale" locale
)
           :cache cache))

(defun list-options-contracts (&key
     underlying-ticker
     ticker
     contract-type
     expiration-date
     as-of
     strike-price
     expired
     underlying-ticker.gte
     underlying-ticker.gt
     underlying-ticker.lte
     underlying-ticker.lt
     expiration-date.gte
     expiration-date.gt
     expiration-date.lte
     expiration-date.lt
     strike-price.gte
     strike-price.gt
     strike-price.lte
     strike-price.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v3/reference/options/contracts
ListOptionsContracts. Query for historical options contracts. This provides both active and expired options contracts. Pass :FOLLOW T to walk next_url."
  (api-get "/v3/reference/options/contracts"
           :query (query
                         "underlying_ticker" (canonicalize-ticker underlying-ticker)
                         "ticker" (canonicalize-ticker ticker)
                         "contract_type" contract-type
                         "expiration_date" expiration-date
                         "as_of" as-of
                         "strike_price" strike-price
                         "expired" expired
                         "underlying_ticker.gte" (canonicalize-ticker underlying-ticker.gte)
                         "underlying_ticker.gt" (canonicalize-ticker underlying-ticker.gt)
                         "underlying_ticker.lte" (canonicalize-ticker underlying-ticker.lte)
                         "underlying_ticker.lt" (canonicalize-ticker underlying-ticker.lt)
                         "expiration_date.gte" expiration-date.gte
                         "expiration_date.gt" expiration-date.gt
                         "expiration_date.lte" expiration-date.lte
                         "expiration_date.lt" expiration-date.lt
                         "strike_price.gte" strike-price.gte
                         "strike_price.gt" strike-price.gt
                         "strike_price.lte" strike-price.lte
                         "strike_price.lt" strike-price.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-contract (options-ticker &key as-of (cache t))
  "GET /v3/reference/options/contracts/{options_ticker}
GetOptionsContract. Get an options contract"
  (api-get (format nil "/v3/reference/options/contracts/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "as_of" as-of
)
           :cache cache))

(defun list-stock-splits (&key
     ticker
     execution-date
     reverse-split
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     execution-date.gte
     execution-date.gt
     execution-date.lte
     execution-date.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v3/reference/splits
ListStockSplits. Get a list of historical stock splits, including the ticker symbol, the execution date, and the factors of the split ratio. Pass :FOLLOW T to walk next_url."
  (api-get "/v3/reference/splits"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "execution_date" execution-date
                         "reverse_split" reverse-split
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "execution_date.gte" execution-date.gte
                         "execution_date.gt" execution-date.gt
                         "execution_date.lte" execution-date.lte
                         "execution_date.lt" execution-date.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-tickers (&key
     ticker
     type
     market
     exchange
     cusip
     cik
     date
     search
     active
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /v3/reference/tickers
ListTickers. Query all ticker symbols which are supported by Massive. This API currently includes Stocks/Equities, Indices, Forex, and Crypto. Pass :FOLLOW T to walk next_url."
  (api-get "/v3/reference/tickers"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "type" type
                         "market" market
                         "exchange" exchange
                         "cusip" cusip
                         "cik" cik
                         "date" date
                         "search" search
                         "active" active
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-ticker-types (&key asset-class locale (cache t))
  "GET /v3/reference/tickers/types
ListTickerTypes. List all ticker types that Massive has."
  (api-get "/v3/reference/tickers/types"
           :query (query
                         "asset_class" asset-class
                         "locale" locale
)
           :cache cache))

(defun get-ticker (ticker &key date (cache t))
  "GET /v3/reference/tickers/{ticker}
GetTicker. Get a single ticker supported by Massive. This response will have detailed information about the ticker and the company behind it."
  (api-get (format nil "/v3/reference/tickers/~A"
                   (ticker-segment ticker))
           :query (query
                         "date" date
)
           :cache cache))

(defun get-unified-snapshot (&key
     ticker
     type
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     ticker.any-of
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/snapshot
Snapshots. Get snapshots for assets of all types Pass :FOLLOW T to walk next_url."
  (api-get "/v3/snapshot"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "type" type
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-indices-snapshot (&key
     ticker.any-of
     ticker
     ticker.gte
     ticker.gt
     ticker.lte
     ticker.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/snapshot/indices
IndicesSnapshot. Get a Snapshot of indices data for said tickers Pass :FOLLOW T to walk next_url."
  (api-get "/v3/snapshot/indices"
           :query (query
                         "ticker.any_of" (canonicalize-ticker ticker.any-of)
                         "ticker" (canonicalize-ticker ticker)
                         "ticker.gte" (canonicalize-ticker ticker.gte)
                         "ticker.gt" (canonicalize-ticker ticker.gt)
                         "ticker.lte" (canonicalize-ticker ticker.lte)
                         "ticker.lt" (canonicalize-ticker ticker.lt)
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-options-chain (underlying-asset
    &key
     strike-price
     expiration-date
     contract-type
     strike-price.gte
     strike-price.gt
     strike-price.lte
     strike-price.lt
     expiration-date.gte
     expiration-date.gt
     expiration-date.lte
     expiration-date.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/snapshot/options/{underlyingAsset}
OptionsChain. Get the snapshot of all options contracts for an underlying ticker. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/snapshot/options/~A"
                   (ticker-segment underlying-asset))
           :query (query
                         "strike_price" strike-price
                         "expiration_date" expiration-date
                         "contract_type" contract-type
                         "strike_price.gte" strike-price.gte
                         "strike_price.gt" strike-price.gt
                         "strike_price.lte" strike-price.lte
                         "strike_price.lt" strike-price.lt
                         "expiration_date.gte" expiration-date.gte
                         "expiration_date.gt" expiration-date.gt
                         "expiration_date.lte" expiration-date.lte
                         "expiration_date.lt" expiration-date.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-option-contract (underlying-asset option-contract &key (follow nil) (max-pages *max-pages*) (cache nil))
  "GET /v3/snapshot/options/{underlyingAsset}/{optionContract}
OptionContract. Get the snapshot of an option contract for a stock equity. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/snapshot/options/~A/~A"
                   (ticker-segment underlying-asset)
                   (ticker-segment option-contract))
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-trades-crypto (crypto-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/trades/{cryptoTicker}
TradesCrypto. Get trades for a crypto ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/trades/~A"
                   (ticker-segment crypto-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-trades-options (options-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/trades/{optionsTicker}
TradesOptions. Get trades for an options ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/trades/~A"
                   (ticker-segment options-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-stock-trades (stock-ticker
    &key
     timestamp
     timestamp.gte
     timestamp.gt
     timestamp.lte
     timestamp.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache nil))
  "GET /v3/trades/{stockTicker}
Trades. Get trades for a ticker symbol in a given time range. Pass :FOLLOW T to walk next_url."
  (api-get (format nil "/v3/trades/~A"
                   (ticker-segment stock-ticker))
           :query (query
                         "timestamp" timestamp
                         "timestamp.gte" timestamp.gte
                         "timestamp.gt" timestamp.gt
                         "timestamp.lte" timestamp.lte
                         "timestamp.lt" timestamp.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-financials (&key
     ticker
     cik
     company-name
     sic
     filing-date
     period-of-report-date
     timeframe
     include-sources
     company-name.search
     filing-date.gte
     filing-date.gt
     filing-date.lte
     filing-date.lt
     period-of-report-date.gte
     period-of-report-date.gt
     period-of-report-date.lte
     period-of-report-date.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /vX/reference/financials
ListFinancials. Get historical financial data for a stock ticker. The financials data is extracted from XBRL from company SEC filings using the methodology outlined here. Pass :FOLLOW T to walk next_url."
  (api-get "/vX/reference/financials"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "cik" cik
                         "company_name" company-name
                         "sic" sic
                         "filing_date" filing-date
                         "period_of_report_date" period-of-report-date
                         "timeframe" timeframe
                         "include_sources" include-sources
                         "company_name.search" company-name.search
                         "filing_date.gte" filing-date.gte
                         "filing_date.gt" filing-date.gt
                         "filing_date.lte" filing-date.lte
                         "filing_date.lt" filing-date.lt
                         "period_of_report_date.gte" period-of-report-date.gte
                         "period_of_report_date.gt" period-of-report-date.gt
                         "period_of_report_date.lte" period-of-report-date.lte
                         "period_of_report_date.lt" period-of-report-date.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun list-ipos (&key
     ticker
     us-code
     isin
     listing-date
     ipo-status
     listing-date.gte
     listing-date.gt
     listing-date.lte
     listing-date.lt
     order
     limit
     sort
     (follow nil)
     (max-pages *max-pages*)
     (cache t))
  "GET /vX/reference/ipos
ListIPOs. The IPOs API provides access to detailed information about Initial Public Offerings (IPOs), including both upcoming and historical events. With this API, you can query for a comprehensive list of IPOs, along with key details such as the issuer name, ticker symbol, ISIN, IPO... Pass :FOLLOW T to walk next_url."
  (api-get "/vX/reference/ipos"
           :query (query
                         "ticker" (canonicalize-ticker ticker)
                         "us_code" us-code
                         "isin" isin
                         "listing_date" listing-date
                         "ipo_status" ipo-status
                         "listing_date.gte" listing-date.gte
                         "listing_date.gt" listing-date.gt
                         "listing_date.lte" listing-date.lte
                         "listing_date.lt" listing-date.lt
                         "order" order
                         "limit" limit
                         "sort" sort
)
           :follow follow
           :max-pages max-pages
           :cache cache))

(defun get-events (id &key types (cache t))
  "GET /vX/reference/tickers/{id}/events
GetEvents. Get a timeline of events for the entity associated with the given ticker, CUSIP, or Composite FIGI."
  (api-get (format nil "/vX/reference/tickers/~A/events"
                   (ticker-segment id))
           :query (query
                         "types" types
)
           :cache cache))


(export
 '(
get-benzinga-v1-analyst-insights
  get-benzinga-v1-analysts
  get-benzinga-v1-bulls-bears-say
  get-benzinga-v1-consensus-ratings-ticker
  get-benzinga-v1-earnings
  get-benzinga-v1-firms
  get-benzinga-v1-guidance
  get-benzinga-v1-ratings
  get-benzinga-v2-news
  get-consumer-spending-eu-v1-merchant-aggregates
  get-consumer-spending-eu-v1-merchant-hierarchy
  get-crypto-v1-exchanges
  get-etf-global-v1-analytics
  get-etf-global-v1-constituents
  get-etf-global-v1-fund-flows
  get-etf-global-v1-profiles
  get-etf-global-v1-taxonomies
  get-fed-v1-funding-conditions
  get-fed-v1-inflation
  get-fed-v1-inflation-expectations
  get-fed-v1-labor-market
  get-fed-v1-treasury-yields
  get-forex-v1-exchanges
  get-futures-aggregates
  get-futures-v1-contracts
  get-futures-v1-exchanges
  get-futures-v1-market-status
  get-futures-v1-products
  get-futures-v1-quotes-ticker
  get-futures-v1-schedules
  get-futures-v1-snapshot
  get-futures-v1-trades-ticker
  get-options-v1-exchanges
  get-options-v3-quotes-ticker
  get-options-v3-trades-ticker
  get-stocks-dev-trades-ticker
  get-stocks-filings-10-k-v-x-sections
  get-stocks-filings-10-k-v-x-0-sections
  get-stocks-filings-8-k-v-x-disclosures
  get-stocks-filings-8-k-v-x-text
  get-stocks-filings-v-x-13-f
  get-stocks-filings-v-x-form-3
  get-stocks-filings-v-x-form-4
  get-stocks-filings-v-x-index
  get-stocks-filings-v-x-risk-factors
  get-stocks-financials-v1-balance-sheets
  get-stocks-financials-v1-cash-flow-statements
  get-stocks-financials-v1-income-statements
  get-stocks-financials-v1-ratios
  get-stocks-taxonomies-v-x-disclosures
  get-stocks-taxonomies-v-x-risk-factors
  get-stocks-v1-dividends
  get-stocks-v1-exchanges
  get-stocks-v1-short-interest
  get-stocks-v1-short-volume
  get-stocks-v1-splits
  get-stocks-v-x-float
  get-tmx-v1-corporate-events
  get-real-time-currency-conversion
  get-deprecated-historic-crypto-trades
  get-deprecated-historic-forex-quotes
  get-crypto-ema
  get-forex-ema
  get-indices-ema
  get-options-ema
  get-stock-ema
  get-crypto-macd
  get-forex-macd
  get-indices-macd
  get-options-macd
  get-stock-macd
  get-crypto-rsi
  get-forex-rsi
  get-indices-rsi
  get-options-rsi
  get-stock-rsi
  get-crypto-sma
  get-forex-sma
  get-indices-sma
  get-options-sma
  get-stock-sma
  get-last-trade-crypto
  get-last-quote-currencies
  get-market-status
  get-market-holidays
  get-crypto-open-close
  get-indices-open-close
  get-options-open-close
  get-stocks-open-close
  get-v1-reference-ipos
  list-filings
  get-filing
  list-filing-files
  get-filing-file
  get-related-companies
  get-snapshot-summary
  get-grouped-crypto-aggregates
  get-grouped-forex-aggregates
  get-grouped-stocks-aggregates
  get-previous-crypto-aggregates
  get-crypto-aggregates
  get-previous-forex-aggregates
  get-forex-aggregates
  get-previous-indices-aggregates
  get-indices-aggregates
  get-previous-options-aggregates
  get-options-aggregates
  get-previous-stocks-aggregates
  get-stocks-aggregates
  get-stock-last-quote
  get-last-trade-options
  get-stock-last-trade
  list-news
  get-crypto-snapshot-tickers
  get-crypto-snapshot-ticker
  get-deprecated-crypto-snapshot-ticker-book
  get-crypto-snapshot-direction
  get-forex-snapshot-tickers
  get-forex-snapshot-ticker
  get-forex-snapshot-direction
  get-stocks-snapshot-tickers
  get-stocks-snapshot-ticker
  get-stocks-snapshot-direction
  get-deprecated-historic-stocks-quotes
  get-deprecated-historic-stocks-trades
  get-quotes-fx
  get-quotes-options
  get-stock-quotes
  list-conditions
  list-dividends
  list-exchanges
  list-options-contracts
  get-options-contract
  list-stock-splits
  list-tickers
  list-ticker-types
  get-ticker
  get-unified-snapshot
  get-indices-snapshot
  get-options-chain
  get-option-contract
  get-trades-crypto
  get-trades-options
  get-stock-trades
  list-financials
  list-ipos
  get-events
))
