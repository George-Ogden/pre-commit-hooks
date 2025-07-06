#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . no-debug -v --files $DIRECTORY/test_data/debug_expression.cu | tee $LOG && exit 1
grep debug_expression.cu:2 $LOG
