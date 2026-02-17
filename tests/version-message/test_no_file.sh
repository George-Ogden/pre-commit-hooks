#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)
CWD=`pwd`

cd "$(mktemp -d)"
git init
git config user.email github-actions[bot]@users.noreply.github.com
git config user.name "github-actions[bot]"
cp $DIRECTORY/test_data/.pre-commit-config.yaml .
sed -i "s,repo: \.,repo: $CWD," .pre-commit-config.yaml

git add .
git commit -am "Initial commit"
pre-commit install

touch extra-file
git add extra-file
git commit extra-file -m "Add extra file"

[ "$(git log -n 1 --format="%s")" == "Add extra file" ]
