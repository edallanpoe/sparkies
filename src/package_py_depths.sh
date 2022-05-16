#!/bin/bash

set -e

DEPTHS_PATH=$(which python | sed -e "s/bin\/python/lib\/python3.8\/site-packages/g")
TARGET_PATH=$(dirname $(realpath $0))

rm -fv $TARGET_PATH/sparkies_bundle.zip

cd $DEPTHS_PATH && zip -r $TARGET_PATH/sparkies_bundle.zip .
