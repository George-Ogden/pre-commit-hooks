#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files "$DIRECTORY/test_data/invalid symbols and spaces !@#\$%^&*()'\"[]{}.jl" | tee $LOG && exit 1
grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.jl:2: <<<<<<<" $LOG
grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.jl:4: =======" $LOG
grep -F "invalid symbols and spaces !@#\$%^&*()'\"[]{}.jl:6: >>>>>>>" $LOG
