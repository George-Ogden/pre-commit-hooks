#!/usr/bin/env bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . dbg-check -v --files $DIRECTORY/test_data/empty.h++
