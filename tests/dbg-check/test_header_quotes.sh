#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/debug_header_quotes.hxx | tee $LOG && exit 1
grep debug_header_quotes.hxx:1 $LOG
