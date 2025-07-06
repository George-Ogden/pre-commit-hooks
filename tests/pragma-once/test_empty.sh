#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit try-repo . pragma-once -v --files $DIRECTORY/test_data/empty.hpp | tee $LOG && exit 1
grep empty.hpp $LOG
