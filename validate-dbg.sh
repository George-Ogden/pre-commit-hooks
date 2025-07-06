#!/usr/bin/bash

LOG=$(mktemp)

EXITCODE=0
for file in "$@"; do
    grep -nE 'dbg *\(' $file > $LOG
    while IFS= read -r line; do
        printf "\`dbg\` expression found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

    grep -nE '^#include *(\"dbg\.h\"|<dbg\.h>)' $file > $LOG
    while IFS= read -r line; do
        printf "\`dbg.h\` import found in %s:%s\n" "$file" "$line"
        EXITCODE=1
    done < "$LOG";

done

exit $EXITCODE
