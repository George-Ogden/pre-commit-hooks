#!/usr/bin/bash

LOG=$(mktemp)

. ./utils.sh

EXITCODE=0
for file in "$@"; do
    for word in todo fixme; do
        neat_word_search "$word"
        while IFS= read -r line; do
            printf "\"$word\" found in %s:%s\n" "$file" "$line"
            EXITCODE=1
        done < "$LOG";
    done
done

rm $LOG
exit $EXITCODE
