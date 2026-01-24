#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . todo-check -v --files $DIRECTORY/test_data/deleteme.js | tee $LOG && exit 1
grep -F 'deleteme.js:2: // deleteme' $LOG
