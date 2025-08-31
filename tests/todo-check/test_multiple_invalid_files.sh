#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . todo-check -v --files $DIRECTORY/test_data/todo.rs $DIRECTORY/test_data/fixme.jl | tee $LOG && exit 1
grep -F todo.rs:2 $LOG
grep -F fixme.jl:2 $LOG
