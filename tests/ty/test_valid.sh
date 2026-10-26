#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . ty-check -v --config $DIRECTORY/test_data/valid/.pre-comimt-config.yaml --files $DIRECTORY/test_data/valid.py
