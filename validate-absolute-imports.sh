#!/usr/bin/env bash

LOG=$(mktemp)

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1 ; pwd -P )
. $SCRIPT_DIR/utils.sh
EXITCODE=0

for file in "$@"; do
    neat_pattern_search '[[:space:]]*from +src(\.| )'
    while IFS= read -r line; do
        printf "Absolute import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done <"$LOG"
done

exit $EXITCODE
