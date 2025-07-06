#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . format-yaml -v --files $DIRECTORY/test_data/invalid.yaml && exit 1
diff $DIRECTORY/test_data/invalid{-expected,}.yaml
