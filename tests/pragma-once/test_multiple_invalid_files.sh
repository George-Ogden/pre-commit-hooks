#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . pragma-once -v --files $DIRECTORY/test_data/{no_pragma.h++,late_pragma.hxx} | tee $LOG && exit 1
grep '^No.*no_pragma\.h\+\+' $LOG
grep -F 'late_pragma.hxx' $LOG | grep -v '^No'
