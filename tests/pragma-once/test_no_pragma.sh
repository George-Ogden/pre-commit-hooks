#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . pragma-once -v --files $DIRECTORY/test_data/no_pragma.h++ | tee $LOG && exit 1
grep -F no_pragma.h++ $LOG
grep '^No' $LOG
