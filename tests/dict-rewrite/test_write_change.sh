#!/bin/bash

set -e
set -o pipefail
DIRECTORY=$(dirname $0)
LOG=`mktemp`

pre-commit run --config $DIRECTORY/test_data/write-config.yaml --files $DIRECTORY/test_data/errors.py -v | tee $LOG && exit 1
grep -E "^Fixed 6 errors in .*/errors\.py'\.\$" $LOG
diff $DIRECTORY/test_data/{errors.py,expected.py}
