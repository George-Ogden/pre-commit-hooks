#!/usr/bin/env bash

LOG=$(mktemp)

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1 ; pwd -P )
. $SCRIPT_DIR/utils.sh
EXITCODE=0

DIRECTORY="src"

FILES=()

while [[ $# -gt 0 ]]; do
  case $1 in
    --disallowed-module)
      DIRECTORY="$2"
      shift
      shift
      ;;
    *)
      FILES+=("$1")
      shift
      ;;
  esac
done

for file in "${FILES[@]}"; do
    neat_pattern_search "[[:space:]]*from +($DIRECTORY)(\.| )"
    while IFS= read -r line; do
        printf "Absolute import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done <"$LOG"
done


exit $EXITCODE
