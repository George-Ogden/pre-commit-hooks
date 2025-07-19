#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/lfs-conflict.zip | tee $LOG && exit 1
grep -F lfs-conflict.zip:2 $LOG | grep '<<<<<<<'
grep -F lfs-conflict.zip:4 $LOG | grep '======='
grep -F lfs-conflict.zip:6 $LOG | grep '>>>>>>>'
