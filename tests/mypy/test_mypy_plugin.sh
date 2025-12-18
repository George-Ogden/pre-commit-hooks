#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

cd $DIRECTORY/test_data/plugin
git init
pre-commit install
pre-commit run mypy --files * | tee $LOG && exit 1
rm -rf .git
grep -F AssertionError $LOG
