#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . no-debug -v --files $DIRECTORY/test_data/debug_statements.cpp | tee $LOG && exit 1
grep debug_statements.cpp:2 $LOG
grep debug_statements.cpp:3 $LOG
