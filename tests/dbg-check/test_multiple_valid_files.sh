#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/no_errors.cxx $DIRECTORY/test_data/empty.h++
