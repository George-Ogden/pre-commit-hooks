#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/{conflict.js,multiple-conflicts.py,no-conflict.rst} | tee $LOG && exit 1
grep -F multiple-conflicts.py:2 $LOG | grep '<<<<<<<'
grep -F multiple-conflicts.py:4 $LOG | grep '======='
grep -F multiple-conflicts.py:6 $LOG | grep '>>>>>>>'
grep -F multiple-conflicts.py:14 $LOG | grep '<<<<<<<'
grep -F multiple-conflicts.py:16 $LOG | grep '======='
grep -F multiple-conflicts.py:18 $LOG | grep '>>>>>>>'
grep -F conflict.js:2 $LOG | grep '<<<<<<<'
grep -F conflict.js:4 $LOG | grep '======='
grep -F conflict.js:6 $LOG | grep '>>>>>>>'
