#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dict-rewrite -v --files $DIRECTORY/test_data/keywords.py | tee $LOG && exit 1
grep -Poz 'keywords\.py:1:10: {\n    "match": True,\n}' $LOG
! grep -F 'False' $LOG
