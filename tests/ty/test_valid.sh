#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . --config $DIRECTORY/test_data/valid/.pre-comimt-config.yaml ty-check -v --files $DIRECTORY/test_data/valid.py
