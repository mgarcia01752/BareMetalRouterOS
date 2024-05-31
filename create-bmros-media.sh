#!/usr/bin/env bash

source lib/common.sh

set -e

WIC_IMAGE="${BMR_x86_64_TMP_DEPLOY_IMAGE_PATH}/${BMR_x86_64_WIC_IMAGE_FILENAME}"

usage() {
    echo "Usage: $0 -d <device>"
    echo "  -d <device>     : Target device (e.g., /dev/sdX)"
    exit 1
}

check_device() {
    if [ ! -b "$1" ]; then
        echo "Error: Device $1 does not exist."
        exit 1
    fi
}

unmount_device_partitions() {
    echo "Unmounting all partitions on $1..."
    for partition in $(lsblk -ln -o NAME "$1" | grep -v "^$(basename "$1")$"); do
        sudo umount "/dev/$partition" || true
    done
}

format_device() {
    echo "Formatting the device $1..."
    sudo parted "$1" --script mklabel gpt
    sudo parted "$1" --script mkpart primary ext4 1MiB 100%
    sleep 2
    sudo mkfs.ext4 -F "${1}1"
}

check_image() {
    if [ ! -f "$1" ]; then
        echo "Error: Image file $1 does not exist."
        exit 1
    fi
}

while getopts ":d:" opt; do
    case "${opt}" in
        d)
            DEVICE=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done

if [ -z "${DEVICE}" ]; then
    usage
fi

if [ "${DEVICE}" == "/dev/sda" ]; then
    echo "Error: ${DEVICE} is the main device. Aborting."
    exit 1
fi

check_device "${DEVICE}"

sudo chmod 666 "${DEVICE}"

unmount_device_partitions "${DEVICE}"

format_device "${DEVICE}"

cd ${POKY_DIR_NAME}

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

check_image ${WIC_IMAGE}

display_banner "Creating bootable media"

bitbake bmaptool-native -c addto_recipe_sysroot

oe-run-native bmaptool-native bmaptool copy "${WIC_IMAGE}" "${DEVICE}"

echo "Image copied successfully to ${DEVICE}."
