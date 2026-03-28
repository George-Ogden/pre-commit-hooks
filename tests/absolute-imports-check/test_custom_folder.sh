#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit run -v --config $DIRECTORY/test_data/custom_folder/.pre-commit-config.yaml --files $DIRECTORY/test_data/custom_folder/custom_folder.py | tee $LOG || true

grep -F 'custom_folder.py:1: from custom_folder.none import script' $LOG
grep -F 'custom_folder.py:2: from custom_folder import script2' $LOG
grep -F 'custom_folder.py:6: from custom_folder.bar import fuz' $LOG
grep -F 'custom_folder.py:9: from custom_folder import fuzz' $LOG
