#!/bin/bash

perl -pi -e 's/\{\\scshape TouIST\}/\\touist/g' $1
perl -pi -e 's/\\mdfootnote\{[\d]*\}/\\footnote/g' $1
perl -pi -e 's/\{[\d\.]*\\hspace\*\{0\.5em\}/{/g' $1
perl -pi -e 's/\[\\mdcite\{(.*)\}\{\d*\}\]/\\cite{$1}/g' $1

