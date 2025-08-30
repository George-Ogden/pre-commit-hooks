#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . mypy -v --files $DIRECTORY/test_data/type_error.py | tee $LOG && exit 1
grep -F type_error.py $LOG
