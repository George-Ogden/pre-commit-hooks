#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit run --config $DIRECTORY/test_data/requirements-file/.pre-commit-config.yaml --files $DIRECTORY/test_data/requirements-file/main.py
