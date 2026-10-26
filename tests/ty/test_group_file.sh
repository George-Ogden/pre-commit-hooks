#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)

cd $DIRECTORY/test_data/dependency-group
git init
pre-commit install
pre-commit run ty-check --files main.py -v
rm -rf .git .venv uv.lock
