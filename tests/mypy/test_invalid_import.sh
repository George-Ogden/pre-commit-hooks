#!/bin/bash

set -e
DIRECTORY=$(dirname $0)


pre-commit run --config $DIRECTORY/test_data/import_error/.pre-commit-config.yaml --files $DIRECTORY/test_data/import_error/import_error.py
