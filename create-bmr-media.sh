#!/usr/bin/env bash

source lib/common.sh

set -e

WIC_IMAGE="${BMR_x86_64_TMP_DEPLOY_IMAGE_PATH}/${BMR_x86_64_WIC_IMAGE_FILENAME}"

# Function to display usage
usage() {
    echo "Usage: $0 -d <device>"
    echo "  -d <device>     : Target device (e.g., /dev/sdX)"
    exit 1
}

# Function to check if the device exists
check_device() {
    if [ ! -b "$1" ]; then
        echo "Error: Device $1 does not exist."
        exit 1
    fi
}

# Function to unmount all partitions on the device
unmount_device_partitions() {
    echo "Unmounting all partitions on $1..."
    for partition in $(lsblk -ln -o NAME "$1" | grep -v "^$(basename "$1")$"); do
        sudo umount "/dev/$partition" || true
    done
}

# Function to format the device
format_device() {
    echo "Formatting the device $1..."
    sudo parted "$1" --script mklabel gpt
    sudo parted "$1" --script mkpart primary ext4 1MiB 100%
    sleep 2  # Give the system some time to recognize the new partition
    sudo mkfs.ext4 -F "${1}1"
}

# Function to check if the image file exists
check_image() {
    if [ ! -f "$1" ]; then
        echo "Error: Image file $1 does not exist."
        exit 1
    fi
}

# Parse command-line arguments
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

# Check if all arguments are provided
if [ -z "${DEVICE}" ]; then
    usage
fi

# Prevent running on the main device
if [ "${DEVICE}" == "/dev/sda" ]; then
    echo "Error: ${DEVICE} is the main device. Aborting."
    exit 1
fi

# Check if the device exists
check_device "${DEVICE}"

# Change permissions on the device
sudo chmod 666 "${DEVICE}"

# Unmount all partitions on the device
unmount_device_partitions "${DEVICE}"

# Format the device
format_device "${DEVICE}"

# Navigate to the Yocto Project build environment
cd ${POKY_DIR_NAME}

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

# Check if the image file exists
check_image ${WIC_IMAGE}

display_banner "Creating bootable media"

# Run the bitbake command to ensure bmaptool-native is added to the sysroot
bitbake bmaptool-native -c addto_recipe_sysroot

# Copy the image to the device using bmaptool
oe-run-native bmaptool-native bmaptool copy "${WIC_IMAGE}" "${DEVICE}"

echo "Image copied successfully to ${DEVICE}."
