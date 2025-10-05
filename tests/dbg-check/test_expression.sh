#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/debug_expression.cu | tee $LOG && exit 1
grep -F 'debug_expression.cu:2: return dbg(-1);' $LOG
