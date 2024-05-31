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
BMR_BUILD_DIR="${POKY_DIR}/${BMR_BUILD_DIR_NAME}"

# Check if the build directory exists
if [ ! -d "${BMR_BUILD_DIR}" ]; then
  echo "Error: Build directory ${BMR_BUILD_DIR} not found."
  exit 1
fi

cd ${POKY_DIR}

display_banner "Starting QEMU for Build: ${BMR_BUILD_DIR_NAME}"

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

build_recipe=$(get_last_build_recipe)

# Define the network interfaces
NETDEV_OPTS="-netdev user,id=net0 -device e1000,netdev=net0,mac=52:54:00:12:34:56 \
             -netdev user,id=net1 -device e1000,netdev=net1,mac=52:54:00:12:34:57"

# Path to the QEMU binary
QEMU_BINARY="${POKY_DIR}/scripts/qemu-system-x86_64"

# Path to the kernel image and root filesystem
KERNEL_IMAGE="${POKY_DIR}/tmp/deploy/images/qemux86-64/bzImage"
ROOTFS_IMAGE="${POKY_DIR}/tmp/deploy/images/qemux86-64/${build_recipe}-qemux86-64.ext4"

# Run QEMU with additional network interfaces
$QEMU_BINARY -kernel $KERNEL_IMAGE -append "root=/dev/sda rw console=ttyS0" \
    -hda $ROOTFS_IMAGE -nographic $NETDEV_OPTS
