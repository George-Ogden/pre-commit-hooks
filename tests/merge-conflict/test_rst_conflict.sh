#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/conflict.rst | tee $LOG && exit 1
grep -F 'conflict.rst:1: <<<<<<<' $LOG
grep -F 'conflict.rst:7: >>>>>>>' $LOG
