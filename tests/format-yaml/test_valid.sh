#!/usr/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . format-yaml -v --files $DIRECTORY/test_data/valid.yaml
git diff $DIRECTORY/test_data/valid.yaml
