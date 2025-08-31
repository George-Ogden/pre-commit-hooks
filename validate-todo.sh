#!/usr/bin/bash

LOG=$(mktemp)

EXITCODE=0
for file in "$@"; do
    grep -nwi 'todo' "$file" > "$LOG"
    while IFS= read -r line; do
        printf "\"todo\" found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    grep -nwi 'fixme' "$file" > "$LOG"
    while IFS= read -r line; do
        printf "\"fixme\" found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";
done

exit $EXITCODE
