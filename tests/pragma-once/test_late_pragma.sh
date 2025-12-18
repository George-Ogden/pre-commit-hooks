#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . pragma-once -v --files $DIRECTORY/test_data/late_pragma.hxx | tee $LOG && exit 1
grep -F late_pragma.hxx $LOG | grep -v '^No'
