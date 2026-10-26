#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit run --config $DIRECTORY/test_data/invalid-dependency-group/.pre-commit-config.yaml ty-good --files $DIRECTORY/test_data/invalid-dependency-group/good.py -v
