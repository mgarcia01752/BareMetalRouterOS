#!/usr/bin/bash

# Source the common script
source lib/common.sh

# Force copy the contents of BMR_META_LAYERS to POKY_DIR_NAME
cp -rf ${BMR_META_LAYERS}/* ${POKY_DIR_NAME}
