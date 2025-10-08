#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dict-rewrite -v --files $DIRECTORY/test_data/errors.py | tee $LOG && exit 1
grep -F 'errors.py:4:5: {"a": 3, "b": 4}' $LOG
grep -F 'errors.py:5:5: {"book_mark": 3}' $LOG
grep -F 'errors.py:6:21: {"a": 4, "d": 4}' $LOG
grep -F 'errors.py:6:5: {**f, "g": 3, **{"a": 4, "d": 4}}' $LOG
grep -Poz 'errors\.py:7:5: {\n    "multiline": True,\n}' "$LOG"
