#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=$(mktemp)

! pre-commit try-repo . ty-check -v --config $DIRECTORY/test_data/type_error/.pre-commit-config.yaml --files $DIRECTORY/test_data/type_error/type_error.py | tee $LOG
grep -F type_error.py $LOG
