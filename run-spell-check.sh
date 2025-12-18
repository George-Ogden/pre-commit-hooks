#!/usr/bin/bash

set -o pipefail

FILENAME="${!#}"
ESCAPED_FILENAME=$(printf '%s\n' "$FILENAME" | sed -e 's/[]\/$*.^[]/\\&/g')

codespell "$@" | sed -E "s,$ESCAPED_FILENAME:[[:digit:]]+,commit message error,"
