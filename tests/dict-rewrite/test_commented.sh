#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dict-rewrite -v --files $DIRECTORY/test_data/commented.py | tee $LOG && exit 1
grep -Poz 'commented\.py:9:5: {\n    "C": False,\n}' $LOG
grep -Poz 'commented\.py:13:5: {\n    "D": False,\n}' $LOG
grep -Poz 'commented\.py:19:5: {\n    "F": False,\n}' $LOG
! grep -F 'True' $LOG
