#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/debug_macro.rs | tee $LOG && exit 1
grep -F debug_macro.rs:2 $LOG
