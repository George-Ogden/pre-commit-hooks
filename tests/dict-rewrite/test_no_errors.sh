#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . dict-rewrite -v --files $DIRECTORY/test_data/no_errors.py
