#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`
ROOT=`pwd`

cd $DIRECTORY/test_data/plugin
cp $ROOT/run-mypy.sh .
git init
pre-commit install
pre-commit run mypy --files * | tee $LOG && exit 1
rm -rf .git
grep -F AssertionError $LOG
