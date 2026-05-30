#!/usr/bin/env bash

set -o pipefail
set -e

UNTRACKED_FILES=$(git ls-files --others --exclude-standard --directory --no-empty-directory)
if [ -n "$UNTRACKED_FILES" ]; then
  echo -e "\033[1;31m  Warning: untracked files detected (maybe you missed them or should gitignore them)!\033[0m"
  while IFS= read -r file; do
	echo -e "\033[31m  - $file\033[0m"
  done <<< "$UNTRACKED_FILES"
fi
