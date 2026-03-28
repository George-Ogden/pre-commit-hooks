#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . absolute-imports-check -v --files $DIRECTORY/test_data/empty.py
