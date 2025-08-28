#!/usr/bin/bash

set -o pipefail
LOG=$(mktemp)

for file in "$@"; do
    pip install mypy
    mypy $@
done
