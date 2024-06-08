#!/usr/bin/env bash

source lib/common.sh

START_DIR=${PWD}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo or as root" 
    exit 1
fi

get_last_build_recipe() {
  echo $(tail -n 1 ${START_DIR}/.last_build_recipe)
}

BUILD_DIR=${PWD}
POKY_DIR="${BUILD_DIR}/${POKY_DIR_NAME}"
BMROS_BUILD_DIR="${POKY_DIR}/${BMROS_BUILD_DIR_NAME}"

# Check if the build directory exists
if [ ! -d "${BMROS_BUILD_DIR}" ]; then
  echo "Error: Build directory ${BMROS_BUILD_DIR} not found."
  exit 1
fi

cd ${POKY_DIR}

source oe-init-build-env ${BMROS_BUILD_DIR_NAME}

build_recipe=$(get_last_build_recipe)

display_banner "Starting QEMU for Build: ${build_recipe}"
sleep 5

${POKY_DIR}/scripts/runqemu nographic "tmp/deploy/images/qemux86-64/${build_recipe}-qemux86-64.rootfs.qemuboot.conf"
