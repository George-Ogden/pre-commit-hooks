#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`
ROOT=`pwd`

cd $DIRECTORY/test_data/pre-commit-config
git init
pre-commit install
pre-commit run todo-check --files *  .*
rm -rf .git
