#!/usr/bin/env bash

source lib/common.sh

display_banner "Updating ${BMROS_META_LAYERS} -> ${POKY_DIR_NAME}"
cp -rf ${BMROS_META_LAYERS}/* ${POKY_DIR_NAME}
