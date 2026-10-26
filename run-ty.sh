#!/usr/bin/env bash

set -e
set -o pipefail

DEPENDENCY_GROUP="types"

while [[ $# -gt 0 ]]; do
	case $1 in
	-g | --group)
		DEPENDENCY_GROUP="$2"
		shift
		shift
		;;
	*)
		TY_ARGS+=("$1")
		shift
		;;
	esac
done

if ! which -s uv && which -s pip; then
	pip install uv -qqq
fi

uv sync --group "$DEPENDENCY_GROUP" --inexact || true
uv tool install ty

uv run --no-sync ty check "${TY_ARGS[@]}"
