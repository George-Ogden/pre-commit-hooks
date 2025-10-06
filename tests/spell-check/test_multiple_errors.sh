#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . spell-check-commit-msgs -v --hook-stage commit-msg --commit-msg-filename $DIRECTORY/test_data/multiple-errors.txt | tee $LOG && exit 1
grep -F 'commit message error: Uplod ==> Upload' $LOG
grep -F 'commit message error: Includs ==> Includes' $LOG
grep -F 'commit message error: Adn ==> And' $LOG
grep -F 'commit message error: tooo ==> todo, too, tool, took' $LOG
