#! /usr/bin/env bash
#
# touist-to-latex-et-verbatim.sh
# Copyright (C) 2018 Maël Valais <mael.valais@gmail.com>
#
# Distributed under terms of the MIT license.
#

if ! which madoko >/dev/null 2>&1 || ! which touist >/dev/null 2>&1; then
    echo 'error: missing madoko or touist'
    exit 1
fi

mkdir -p /tmp/mdk
tmp=/tmp/mdk/temp.mdk
cat > $tmp.touist


cat <<'JSON' > /tmp/mdk/touist.json
{
  "displayName": "Touist",
  "name": "touist",
  "mimeTypes": ["text/x-touist"],
  "fileExtensions": ["touist", "touistl"],

  "lineComment": ";;",

  "keywords": [
    "end",
    "in",
    "subset",
    "empty",
    "union",
    "inter",
    "diff",
    "exact",
    "atmost",
    "atleast",
    "bigand",
    "bigor",
    "when",
    "card",
    "mod",
    "sqrt",
    "int",
    "float",
    "abs",
    "if",
    "then",
    "else",
    "mod",
    "let",
    "data",
    "powerset",
    ":",
    "exists",
    "forall",
    "for"
  ],

  "extraKeywords": ["Top", "Bot", "true", "false"],

  "builtins": ["and", "or", "xor", "=>", "<=>", "not"],
  "operators": [
    "=",
    ">",
    "<",
    "==",
    "<=",
    ">=",
    "!=",
    "&&",
    "||",
    "+",
    "-",
    "*",
    "/"
  ],
  "symbols": "[=><!~?:&|+\\-*\\/\\^%]+",
  "escapes": "\\\\(?:[abfnrtv\\\\\"']|x[0-9A-Fa-f]{1,4}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})",

  "tokenizer": {
    "root": [
      [
        "[a-zA-Z_][\\w]*",
        {
          "cases": {
            "@builtins": "predefined.identifier",
            "@keywords": "keyword",
            "@extraKeywords": "keyword.extra",
            "@default": "identifier"
          }
        }
      ],

      { "include": "@whitespace" },

      ["[{}()\\[\\]]", "@brackets"],
      ["[,.]", "delimiter"],

      [
        "@symbols",
        {
          "cases": {
            "@operators": "predefined.operator",
            "@default": ""
          }
        }
      ],

      ["[$][a-zA-Z_][\\w]*", "constructor.identifier"],
      ["\\d*\\.\\d+([eE][\\-+]?\\d+)?[fFdD]?", "number.float"],
      ["\\d+[lL]?", "number"]
    ],

    "whitespace": [["[ \\t\\r\\n]+", "white"], [";;.*$", "comment"]]
  }
}
JSON

cat <<'EOF' > $tmp
Colorizer: touist
.code2 { language: Touist }
Touist: [TouIST]{font-variant: small-caps}

``` Touist
EOF
cat $tmp.touist >> $tmp
echo '```' >> $tmp
cd /tmp/mdk

madoko $tmp --tex --fragment
cat /tmp/mdk/out/temp.tex

echo
echo -e "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo
echo '\['
touist --qbf --latex -- $tmp.touist
echo '\]'
