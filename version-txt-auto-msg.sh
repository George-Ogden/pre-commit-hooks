#!/usr/bin/env bash

set -o pipefail
set -e

FILE="version.txt"
COMMIT_MSG_FILE=$1

OLD_VERSION=$(git show HEAD:$FILE 2>/dev/null || true)
NEW_VERSION=$(cat $FILE || true)

if [ ! -s "$COMMIT_MSG_FILE" ] && [ -n "$OLD_VERSION" ] && [ "$OLD_VERSION" != "$NEW_VERSION" ]; then
    MSG="Bump version $OLD_VERSION -> $NEW_VERSION"
    echo $MSG > "$1"
fi
