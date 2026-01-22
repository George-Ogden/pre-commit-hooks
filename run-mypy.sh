#!/usr/bin/env bash

set -e
set -o pipefail

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

if ! which -s uv && which -s pip; then
  pip install uv -qqq
fi

SYSTEM_FLAG=
if python -c "import sys; exit(sys.prefix != sys.base_prefix)"; then
  SYSTEM_FLAG="--system"
fi

uv pip install "${REQUIREMENTS[@]}" -qqq $SYSTEM_FLAG || true

mypy "${MYPY_ARGS[@]}"
