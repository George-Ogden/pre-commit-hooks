#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . spell-check-commit-msgs -v --hook-stage commit-msg --commit-msg-filename $DIRECTORY/test_data/one-error.txt | tee $LOG && exit 1
grep -F 'commit message error: speling ==> spelling' $LOG
