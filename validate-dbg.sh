#!/usr/bin/env bash

LOG=$(mktemp)

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1 ; pwd -P )
. $SCRIPT_DIR/utils.sh

EXITCODE=0
for file in "$@"; do
    neat_pattern_search 'dbg!? *\('
    while IFS= read -r line; do
        printf "\`dbg\` expression found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    neat_pattern_search '^[[:space:]]*#include[[:space:]]+(\"dbg\.h\"|<dbg\.h>)[[:space:]]*$'
    while IFS= read -r line; do
        printf "\`dbg.h\` include found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    neat_pattern_search '^(.*[[:space:]])?import[[:space:]](.*[[:space:]])?dbg([[:space:]].*)?$'
    while IFS= read -r line; do
        printf "\`dbg\` import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

done

rm -f "$LOG"
exit $EXITCODE
