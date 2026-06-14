#!/usr/bin/env bash

source lib/common.sh

display_banner "Updating ${BMROS_META_LAYERS} -> ${POKY_DIR_NAME}"
mkdir -p "${POKY_DIR_NAME}/layers"
rm -rf "${POKY_DIR_NAME}/layers/${BB_LAYER_BARE_METAL_ROUTER}"
cp -rf "${BMROS_META_LAYERS}/${BB_LAYER_BARE_METAL_ROUTER}" "${POKY_DIR_NAME}/layers"
