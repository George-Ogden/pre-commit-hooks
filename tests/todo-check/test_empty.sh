#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . todo-check -v --files $DIRECTORY/test_data/empty.txt
