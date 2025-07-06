#!/usr/bin/bash

set -o pipefail

PRAGMA_PATTERN='^[[:space:]]*#pragma[[:space:]]+once[[:space:]]*$'
INCLUDE_PATTERN='^[[:space:]]*#include'

EXITCODE=0
for file in "$@"; do
    sed "/$INCLUDE_PATTERN/q" "$file" | grep -qE "$PRAGMA_PATTERN" || {
        if grep -qE "$PRAGMA_PATTERN" "$file"; then
            printf "\`#pragma once\` found in $file but after the first \`#include\`\n"
        else
            printf "No \`#pragma once\` found in $file\n"
        fi
        EXITCODE=1
    }
done

exit $EXITCODE
