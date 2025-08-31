#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . todo-check -v --files $DIRECTORY/test_data/fixme.jl | tee $LOG && exit 1
grep -F fixme.jl:2 $LOG
