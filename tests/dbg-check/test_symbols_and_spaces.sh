#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files "$DIRECTORY/test_data/invalid symbols and spaces !@#\$%^&*()'\"[]{}.hpp" | tee $LOG && exit 1
grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.hpp:1: #include <dbg.h>" $LOG
grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.hpp:4: dbg(10);" $LOG
pre-commit try-repo . dbg-check -v --files "$DIRECTORY/test_data/valid symbols and spaces !@#\$%^&*()'\"[]{}.cuh"
