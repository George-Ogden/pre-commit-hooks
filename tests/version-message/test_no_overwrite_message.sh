#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)
CWD=`pwd`

cd "$(mktemp -d)"
git init
cp $DIRECTORY/test_data/{.pre-commit-config.yaml,version.txt} .
sed -i "s,repo: \.,repo: $CWD," .pre-commit-config.yaml

git add .
git commit -am "Initial commit"
pre-commit install

echo "1.4.0" > version.txt
git commit version.txt -m "Here is a message"

[ "$(git log -n 1 --format="%s")" == "Here is a message" ]

echo "1.3.0" > version.txt
git commit version.txt --amend --no-edit

[ "$(git log -n 1 --format="%s")" == "Here is a message" ]
