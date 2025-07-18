#!/bin/bash

set -e
DIRECTORY=$(dirname $0)

pre-commit try-repo . check-merge-conflict -v --files $DIRECTORY/test_data/lfs-no-conflict.npy
