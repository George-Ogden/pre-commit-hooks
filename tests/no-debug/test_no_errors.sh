#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . no-debug -v --files $DIRECTORY/test_data/no_errors.cxx
