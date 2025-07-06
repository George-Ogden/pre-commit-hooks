#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . pragma-once -v --files $DIRECTORY/test_data/includes_pragma.cuh
