#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/conflict.js | tee $LOG && exit 1
grep -F conflict.js:2 $LOG | grep '<<<<<<<'
grep -F conflict.js:4 $LOG | grep '======='
grep -F conflict.js:6 $LOG | grep '>>>>>>>'
