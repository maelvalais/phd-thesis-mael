#!/bin/bash

# Ce script me sert à corriger les choses fausses de madoko
# et à corriger les accents type \'{e}

perl -pi -e 's/\{\\scshape TouIST\}/\\touist/g' $1
perl -pi -e 's/\\mdfootnote\{[\d]*\}/\\footnote/g' $1
perl -pi -e 's/\{[\d\.]*\\hspace\*\{0\.5em\}/{/g' $1
perl -pi -e 's/\[\\mdcite\{(.*)\}\{\d*\}\]/\\cite{$1}/g' $1
perl -pi -e 's/\\\^\{?e\}?/ê/g' $1
perl -pi -e "s/\\\'\{?e\}?/é/g" $1
perl -pi -e 's/\\\`\{?e\}?/è/g' $1

perl -pi -e 's/\\\`\{?a\}?/à/g' $1
perl -pi -e 's/\\\`\{?u\}?/ù/g' $1
perl -pi -e 's/\\\"\{?u\}?/ü/g' $1

perl -pi -e 's/\\\"\{?e\}?/ë/g' $1
perl -pi -e 's/\\\"\{?i\}?/ï/g' $1

perl -pi -e 's/\\\^\{?o\}?/ô/g' $1
