#!/usr/bin/bash

LOG=$(mktemp)

EXITCODE=0
for file in "$@"; do
    grep -nE 'dbg!? *\(' "$file" > "$LOG"
    while IFS= read -r line; do
        printf "\`dbg\` expression found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    grep -nE '^[[:space:]]*#include[[:space:]]+(\"dbg\.h\"|<dbg\.h>)[[:space:]]*$' "$file" > "$LOG"
    while IFS= read -r line; do
        printf "\`dbg.h\` import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    grep -nE '^(.*[[:space:]])?import[[:space:]](.*[[:space:]])?dbg([[:space:]].*)?$' "$file" > "$LOG"
    while IFS= read -r line; do
        printf "\`dbg.h\` import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

done

exit $EXITCODE
