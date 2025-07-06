#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . no-debug -v --files $DIRECTORY/test_data/debug_header_brackets.hpp | tee $LOG && exit 1
grep debug_header_brackets.hpp:3 $LOG
