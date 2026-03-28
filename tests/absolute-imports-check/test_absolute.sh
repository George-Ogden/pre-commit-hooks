#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . absolute-imports-check -v --files $DIRECTORY/test_data/absolute_only.py | tee $LOG && exit 1

grep -F 'absolute_only.py:3: from src.bar import baz' $LOG
grep -F 'absolute_only.py:4: from src.foo import (' $LOG
grep -F 'absolute_only.py:8: from src import foo' $LOG
grep -F 'absolute_only.py:11: from src.bar import fuz' $LOG
grep -F 'absolute_only.py:14: from src import fuzz' $LOG
