#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)

cd $DIRECTORY/test_data/mypy_1_16_1
git init
pre-commit install
pre-commit run mypy --files *
rm -rf .git
