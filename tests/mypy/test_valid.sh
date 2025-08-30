#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . mypy -v --files $DIRECTORY/test_data/valid.py
