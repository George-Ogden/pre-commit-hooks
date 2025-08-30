#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`
ROOT=`pwd`

cd $DIRECTORY/test_data/mypy_1_16_1
cp $ROOT/run-mypy.sh .
git init
pre-commit install
pre-commit run mypy --files *
rm -rf .git
