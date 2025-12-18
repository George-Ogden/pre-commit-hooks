#!/usr/bin/bash

LOG=$(mktemp)

SCRIPT_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1 ; pwd -P )
. $SCRIPT_DIR/utils.sh

CONFLICT_PATTERN='^(<<<<<<<[[:space:]]|=======([[:space:]]|$)|>>>>>>>[[:space:]])'
declare -a CONFLICT_PATTERNS=(
    '^<<<<<<< '
    '^=======[[:space:]]'
    '^=======$'
    '^>>>>>>> '
)

EXITCODE=0
for file in "$@"; do
    file -ib "$file" | grep -qE '^text' || continue
    neat_pattern_search "$CONFLICT_PATTERN"
    while IFS= read -r line; do
        for pattern in "${CONFLICT_PATTERNS[@]}"; do
            if [[ "${file: -4}" == ".rst" ]] && echo "$pattern" | grep -q '='; then
                continue
            fi
            if echo "$line" | cut -d: -f2- | sed -E 's/^[[:space:]]+//' | grep -qE "$pattern"; then
                printf "Merge conflict pattern found in %s:%s\n" "$file" "$line"
                EXITCODE=1
                break
            fi
        done
    done < "$LOG";
done

rm "$LOG"
exit $EXITCODE
