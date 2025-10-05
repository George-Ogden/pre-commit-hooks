#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/debug_statements.cpp | tee $LOG && exit 1
grep -F 'debug_statements.cpp:2: dbg(10);' $LOG
grep -F 'debug_statements.cpp:3: int y = dbg(4);' $LOG
