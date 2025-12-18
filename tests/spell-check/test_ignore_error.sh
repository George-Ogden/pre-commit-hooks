#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit run --config $DIRECTORY/test_data/ignore-error/.pre-commit-config.yaml --hook-stage commit-msg --commit-msg-filename $DIRECTORY/test_data/ignore-error/msg.txt
