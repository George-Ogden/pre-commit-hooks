#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

! pre-commit run --config $DIRECTORY/test_data/invalid-dependency-group/.pre-commit-config.yaml ty-bad --files $DIRECTORY/test_data/invalid-dependency-group/bad.py -v
