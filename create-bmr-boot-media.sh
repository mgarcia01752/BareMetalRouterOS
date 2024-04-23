#!/usr/bin/bash

# Source the common script
source lib/common.sh

ROOTFS_IMAGE="${PWD}/poky/build-bmr/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64.rootfs.ext4"

wait_seconds=5

# Function to display script usage
usage() {
    echo "Usage: $0 -i <rootfs_image> -d <usb_device>"
    echo "Options:"
    echo "  -i <rootfs_image>   Path to the root filesystem image (e.g., core-image-minimal-qemux86-64.rootfs.ext4)"
    echo "  -d <usb_device>     USB device to write the image to (e.g., /dev/sdX)"
    exit 1
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo or as root" 
    exit 1
fi

# Parse command-line options
while getopts "i:d:" opt; do
    case $opt in
        d) USB_DEVICE=$OPTARG ;;
        *) usage ;;
    esac
done

# Verify required options are provided
if [ -z "$ROOTFS_IMAGE" ] || [ -z "$USB_DEVICE" ]; then
    usage
fi

# Unmount USB drive if it's already mounted
umount "$USB_DEVICE"*

sleep $wait_seconds

# Format USB drive
echo "Formatting USB drive..."
mkfs.ext4 -F "$USB_DEVICE"

sleep $wait_seconds

# Write image to USB drive
echo "Writing image to USB drive..."
dd if="$ROOTFS_IMAGE" of="$USB_DEVICE" bs=4M status=progress

sleep $wait_seconds

# Sync and eject USB drive
sync
echo "Image written to USB drive successfully."

sleep $wait_seconds

# Partition and setup GRUB
echo "Setting up GRUB..."
parted -s "$USB_DEVICE" mklabel msdos
parted -s "$USB_DEVICE" mkpart primary ext4 1MiB 100%
parted -s "$USB_DEVICE" set 1 boot on

sleep $wait_seconds

mkfs.ext4 "${USB_DEVICE}1"

sleep $wait_seconds

mount "${USB_DEVICE}1" /mnt

sleep $wait_seconds

mkdir -p /mnt/boot/grub

sleep $wait_seconds

grub-install --target=i386-pc --root-directory=/mnt --boot-directory=/mnt/boot --recheck --no-floppy "$USB_DEVICE"
cp /boot/grub/grub.cfg /mnt/boot/grub/

sleep $wait_seconds

umount /mnt
echo "GRUB installed. USB drive is now bootable."
