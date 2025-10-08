#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit run --config $DIRECTORY/test_data/write-config.yaml --files $DIRECTORY/test_data/no_errors.py
