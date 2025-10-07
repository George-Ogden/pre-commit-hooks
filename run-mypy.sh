#!/usr/bin/bash

set -o pipefail
LOG=$(mktemp)

MYPY_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -r|--requirements-file)
      REQUIREMENTS_FILE="$2"
      shift
      shift
      ;;
    *)
      MYPY_ARGS+=("$1")
      shift
      ;;
  esac
done

REQUIREMENTS=(mypy)

if [[ ! -z "$REQUIREMENTS_FILE" ]]; then
    REQUIREMENTS+=("-r$REQUIREMENTS_FILE")
fi

pip install uv -qqq && uv pip install "${REQUIREMENTS[@]}" --system -qqq && mypy "${MYPY_ARGS[@]}"
