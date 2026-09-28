#!/usr/bin/env python3
"""Generate source/endpoints.lisp and documentation/endpoints.md
from the Massive OpenAPI document.

Usage:
  python3 scripts/generate-endpoints.py [openapi.json]

With no argument the script downloads https://api.massive.com/openapi.
That host is the spec, not a market-data call.
"""

import html
import json
import re
import sys
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC_URL = "https://api.massive.com/openapi"

RENAMES = {
    "AggregatesV1": "get-futures-aggregates",
    "EMA": "get-stock-ema",
    "MACD": "get-stock-macd",
    "RSI": "get-stock-rsi",
    "SMA": "get-stock-sma",
    "LastQuote": "get-stock-last-quote",
    "LastTrade": "get-stock-last-trade",
    "Quotes": "get-stock-quotes",
    "Trades": "get-stock-trades",
    "Snapshots": "get-unified-snapshot",
}

LIVE_HINTS = (
    "/snapshot",
    "/last/",
    "/last_quote",
    "/trades",
    "/quotes",
    "/marketstatus/now",
    "/open-close",
    "/aggs/",
    "/conversion/",
    "/v1/last",
)

HEADER = """\
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
"""


def load_spec(path):
    if path:
        return json.loads(Path(path).read_text())
    with urllib.request.urlopen(SPEC_URL, timeout=60) as response:
        return json.load(response)


def resolve_param(spec, param):
    if "$ref" in param:
        name = param["$ref"].rsplit("/", 1)[-1]
        return spec["components"]["parameters"][name]
    return param


def lisp_param(name):
    name = re.sub(r"([a-z0-9])([A-Z])", r"\1-\2", name)
    return name.replace("_", "-").lower()


def lisp_function_name(oid):
    if oid in RENAMES:
        return RENAMES[oid]
    text = re.sub(r"([a-z0-9])([A-Z])", r"\1-\2", oid)
    text = text.replace("_", "-")
    text = re.sub(r"-+", "-", text).lower().strip("-")
    if text.startswith("deprecated-"):
        rest = text[len("deprecated-"):]
        if rest.startswith("get-"):
            rest = rest[4:]
        text = "get-deprecated-" + rest
    if not (text.startswith("get-") or text.startswith("list-")):
        text = "get-" + text
    if not re.fullmatch(r"[a-z][a-z0-9-]*", text):
        raise SystemExit(f"bad function name {text} from {oid}")
    return text


def clean_text(value):
    if not value:
        return ""
    text = re.sub(r"<br\s*/?>", " ", value, flags=re.I)
    text = re.sub(r"<[^>]+>", "", text)
    text = html.unescape(text)
    text = re.sub(r"\s+", " ", text).strip()
    if len(text) > 280:
        text = text[:277].rsplit(" ", 1)[0] + "..."
    return text


def lisp_string(text):
    return '"' + text.replace("\\", "\\\\").replace('"', '\\"') + '"'


def schema_has_next(spec, schema, seen=None):
    if not isinstance(schema, dict):
        return False
    if seen is None:
        seen = set()
    if "$ref" in schema:
        name = schema["$ref"].rsplit("/", 1)[-1]
        if name in seen:
            return False
        seen.add(name)
        target = spec["components"].get("schemas", {}).get(name, {})
        return schema_has_next(spec, target, seen)
    props = schema.get("properties") or {}
    if "next_url" in props:
        return True
    for key in ("allOf", "anyOf", "oneOf"):
        for sub in schema.get(key) or []:
            if schema_has_next(spec, sub, seen):
                return True
    return False


def operation_paginates(spec, op):
    response = (op.get("responses") or {}).get("200") or {}
    content = (response.get("content") or {}).get("application/json") or {}
    return schema_has_next(spec, content.get("schema") or {})


def cache_default(path):
    return "nil" if any(hint in path for hint in LIVE_HINTS) else "t"


def is_ticker_param(name):
    base = name.split(".")[0].replace("_", "").replace("-", "").lower()
    return "ticker" in base or base in {"underlyingasset", "optioncontract"}


def segment_kind(path, name):
    lowered = name.lower()
    if lowered == "timespan":
        return "timespan-segment"
    if lowered in {"multiplier", "direction", "date", "filing_id", "file_id"}:
        return "path-segment"
    if lowered in {"from", "to"} and "/aggs/" in path:
        return "path-segment"
    return "ticker-segment"


def blurb(oid, op):
    summary = clean_text(op.get("summary") or "")
    description = clean_text(op.get("description") or "")
    if summary and description and len(summary) < 40:
        text = description
    else:
        text = summary or description or "Massive REST endpoint."
    deprecated = oid.lower().startswith("deprecated") or text.lower().startswith(
        "deprecated"
    )
    if deprecated and not text.lower().startswith("deprecated"):
        text = "Deprecated. " + text
    return text


def format_path(template, params_by_name):
    pieces = re.split(r"\{([^}]+)\}", template)
    literal = ""
    args = []
    for index, piece in enumerate(pieces):
        if index % 2 == 0:
            literal += piece.replace("~", "~~")
        else:
            literal += "~A"
            kind = segment_kind(template, piece)
            args.append(f"({kind} {lisp_param(piece)})")
    return literal, args


def emit_function(spec, path, op):
    name = lisp_function_name(op["operationId"])
    raw_params = [
        resolve_param(spec, param)
        for param in (spec["paths"][path].get("parameters") or [])
        + (op.get("parameters") or [])
    ]
    path_order = re.findall(r"\{([^}]+)\}", path)
    by_name = {param["name"]: param for param in raw_params}
    path_params = [by_name[item] for item in path_order]
    query_params = [param for param in raw_params if param.get("in") == "query"]
    paginates = operation_paginates(spec, op)
    cache = cache_default(path)
    positional = " ".join(lisp_param(param["name"]) for param in path_params)
    keys = []
    for param in query_params:
        keys.append(lisp_param(param["name"]))
    if paginates:
        keys.extend(["(follow nil)", "(max-pages *max-pages*)"])
    keys.append(f"(cache {cache})")
    if positional:
        arglist = positional + " &key " + " ".join(keys)
    else:
        arglist = "&key " + " ".join(keys)
    # Keep huge lambda lists readable.
    if len(keys) > 8:
        key_lines = "\n".join(f"     {key}" for key in keys)
        if positional:
            arglist = f"{positional}\n    &key\n{key_lines}"
        else:
            arglist = f"&key\n{key_lines}"
    doc = f"GET {path}\n{op['operationId']}. {blurb(op['operationId'], op)}"
    if paginates:
        doc += " Pass :FOLLOW T to walk next_url."
    lines = [f"(defun {name} ({arglist})"]
    lines.append(f"  {lisp_string(doc)}")
    fmt, fmt_args = format_path(path, by_name)
    if fmt_args:
        arg_text = "\n".join(f"                   {arg}" for arg in fmt_args)
        target = f"(format nil {lisp_string(fmt)}\n{arg_text})"
    else:
        target = lisp_string(path)
    query_pairs = []
    for param in query_params:
        original = param["name"]
        lisp = lisp_param(original)
        expr = f"(canonicalize-ticker {lisp})" if is_ticker_param(original) else lisp
        query_pairs.append(f"                         {lisp_string(original)} {expr}")
    body = [f"  (api-get {target}"]
    if query_pairs:
        body.append("           :query (query")
        body.append("\n".join(query_pairs))
        body.append(")")
    if paginates:
        body.append("           :follow follow")
        body.append("           :max-pages max-pages")
    body.append("           :cache cache))")
    lines.append("\n".join(body))
    return name, "\n".join(lines), path, op["operationId"], blurb(op["operationId"], op)


def main():
    spec_path = sys.argv[1] if len(sys.argv) > 1 else None
    spec = load_spec(spec_path)
    records = []
    for path in sorted(spec["paths"]):
        op = spec["paths"][path]["get"]
        records.append(emit_function(spec, path, op))
    names = [record[0] for record in records]
    if len(names) != len(set(names)):
        raise SystemExit("duplicate function names")
    endpoint_path = ROOT / "source" / "endpoints.lisp"
    parts = [
        HEADER,
        "(in-package #:massive/rest-api)\n",
        "\n\n".join(record[1] for record in records),
        "\n\n(export\n '(",
        "\n  ".join(names),
        "))\n",
    ]
    endpoint_path.write_text("\n".join(parts))
    docs = [
        "# Massive REST endpoints",
        "",
        "Generated from the Massive OpenAPI spec.  "
        "Each row is a function in `massive` and `massive/rest-api`.",
        "",
        "Query arguments use hyphens for underscores.  "
        "A dotted filter stays dotted: `:date.gte`.  "
        "`t` sends `true`, `:false` sends `false`, and `nil` omits the parameter.  "
        "Operations that return `next_url` take `:follow` and `:max-pages`.",
        "",
        "| Function | Operation | Path |",
        "| --- | --- | --- |",
    ]
    for name, _body, path, oid, _blurb in records:
        docs.append(f"| `{name}` | `{oid}` | `{path}` |")
    docs.append("")
    (ROOT / "documentation" / "endpoints.md").write_text("\n".join(docs))
    print(f"wrote {len(records)} endpoints to {endpoint_path}")


if __name__ == "__main__":
    main()
