#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dict-rewrite -v --files $DIRECTORY/test_data/errors.py | tee $LOG && exit 1
grep -F 'errors.py:4:4: {"a": 3, "b": 4}' $LOG
grep -F 'errors.py:5:4: {"book_mark": 3}' $LOG
grep -F 'errors.py:6:20: {"a": 4, "d": 4}' $LOG
grep -F 'errors.py:6:4: {**f, "g": 3, **{"a": 4, "d": 4}}' $LOG
grep -Poz 'errors\.py:7:4: {\n    "multiline": True,\n}' "$LOG"
