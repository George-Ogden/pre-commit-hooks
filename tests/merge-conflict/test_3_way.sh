#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/3-way.yaml | tee $LOG && exit 1
grep -F '3-way.yaml:3: <<<<<<<' $LOG
grep -F '3-way.yaml:5: |||||||' $LOG
grep -F '3-way.yaml:7: =======' $LOG
grep -F '3-way.yaml:9: >>>>>>>' $LOG
