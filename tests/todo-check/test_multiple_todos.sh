#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . todo-check -v --files $DIRECTORY/test_data/multiple_todos.cpp | tee $LOG && exit 1
grep -F 'multiple_todos.cpp:1: // TODO: blah' $LOG
grep -F 'multiple_todos.cpp:3: //TODO blah' $LOG
grep -F 'multiple_todos.cpp:4: /*TODO*/' $LOG
