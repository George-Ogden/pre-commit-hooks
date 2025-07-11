#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/both_issues.cuh | tee $LOG && exit 1
grep -F both_issues.cuh:1 $LOG
grep -F both_issues.cuh:4 $LOG
