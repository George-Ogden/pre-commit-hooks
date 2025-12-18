#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . pragma-once -v --files "$DIRECTORY/test_data/invalid symbols and spaces !@#\$%^&*()'\"[]{}.hpp" | tee $LOG && exit 1
grep '^No' $LOG | grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.hpp"
pre-commit try-repo . pragma-once -v --files "$DIRECTORY/test_data/valid symbols and spaces !@#\$%^&*()'\"[]{}.cuh"
