#!/usr/bin/bash

LOG=$(mktemp)

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
    grep -nE "$CONFLICT_PATTERN" "$file" > "$LOG"
    while IFS= read -r line; do
        for pattern in ${CONFLICT_PATTERNS[@]}; do
            if [[ "${file: -4}" == ".rst" ]] && echo "$pattern" | grep -q '='; then
                continue
            fi
            if echo "$line" | cut -d: -f2- | grep -qE "$pattern"; then
                printf "Merge conflict pattern found in %s:%s\n" "$file" "$line"
                EXITCODE=1
                break
            fi
        done
    done < "$LOG";
done

exit $EXITCODE
