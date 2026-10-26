#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=$(mktemp)

cd $DIRECTORY/test_data/ty-0.0.60
git init
pre-commit install
pre-commit run ty-check --files empty.py -v | tee "$LOG"
grep -F 'DEBUG ty: Version: 0.0.60' "$LOG"
rm -rf .git .venv uv.lock
