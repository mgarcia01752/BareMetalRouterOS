#!/usr/bin/env bash

# Source the common script
source lib/common.sh

# Force copy the contents of BMROS_META_LAYERS to POKY_DIR_NAME
cp -rf ${BMROS_META_LAYERS}/* ${POKY_DIR_NAME}
