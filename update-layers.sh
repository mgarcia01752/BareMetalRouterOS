#!/usr/bin/bash

# Source the common script
source lib/common.sh

SUPPORTED_YOCTO_CODENAME="python3-argcomplete 
# Force copy the contents of BMR_META_LAYERS to POKY_DIR_NAME
cp -rf ${BMR_META_LAYERS}/* ${POKY_DIR_NAME}
