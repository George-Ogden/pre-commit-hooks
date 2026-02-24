#!/usr/bin/env bash

set -o pipefail
set -e

FILE=".mirror.lock"
COMMIT_MSG_FILE=$1

if [ ! -s "$COMMIT_MSG_FILE" ] && [ -f "$FILE" ] && ! git diff --quiet HEAD -- "$FILE"; then
    if git cat-file -e "HEAD:$FILE" 2>/dev/null; then
        MSG="Sync mirror"
    else
        MSG="Install mirror"
    fi
    echo "$MSG" > "$COMMIT_MSG_FILE"
fi
