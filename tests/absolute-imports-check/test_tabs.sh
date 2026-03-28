#!/usr/bin/env bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

sed -i 's/    /\t/g' $DIRECTORY/test_data/tabs.py
pre-commit try-repo . absolute-imports-check -v --files $DIRECTORY/test_data/tabs.py | tee $LOG && exit 1

grep -F 'tabs.py:2: from src.bar import fuz' $LOG
grep -F 'tabs.py:6: from src.bar import fuz' $LOG
