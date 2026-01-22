#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit run --config $DIRECTORY/test_data/invalid-requirements-file/.pre-commit-config.yaml --files $DIRECTORY/test_data/invalid-requirements-file/bad.py -v || exit 0
