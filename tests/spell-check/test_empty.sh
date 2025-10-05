#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . spell-check-commit-msgs -v --hook-stage commit-msg --commit-msg-filename $DIRECTORY/test_data/empty.txt
