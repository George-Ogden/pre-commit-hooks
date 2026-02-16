#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)
CWD=`pwd`

cd "$(mktemp -d)"
git init
cp $DIRECTORY/test_data/.pre-commit-config.yaml .
sed -i "s,repo: \.,repo: $CWD," .pre-commit-config.yaml

git add .
git commit -am "Initial commit"
pre-commit install

cp $DIRECTORY/test_data/version.txt .
git add version.txt
git commit version.txt -m "Create version.txt"

[ "$(git log -n 1 --format="%s")" == "Create version.txt" ]
