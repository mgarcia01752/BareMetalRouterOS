#!/usr/bin/bash

# Source the common script
source lib/common.sh

# Display banner
display_banner "Create Bare Metal Router Boot Media"

# Check if user is root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or using sudo."
    exit 1
fi

# Function to create bootable USB
create_bootable_usb() {
    local usb_device="$1"
    local poky_image_path="$2"

    # Check if the USB device exists
    if [ ! -b "$usb_device" ]; then
        echo "USB device $usb_device not found."
        exit 1
    fi

    display_banner "Creating bootable USB..."
    
    # Unmount USB if mounted
    umount "$usb_device"* &>/dev/null

    # Wipe USB
    display_banner "Wiping USB..."
    wipefs -a "$usb_device" &>/dev/null

    # Format USB to FAT32
    display_banner "Formatting USB to FAT32..."
    mkfs.vfat -F 32 -n "ROUTER_BOOT" "$usb_device" &>/dev/null

    # Check if the Poky image exists
    if [ ! -f "$poky_image_path" ]; then
        echo "Poky image not found at: $poky_image_path"
        exit 1
    fi

    # dd Poky Image to USB
    display_banner "Copying Poky image to USB..."
    dd if="$poky_image_path" of="$usb_device" bs=4M conv=fsync status=progress

    display_banner "Bootable USB creation complete."
}

# Usage function
usage() {
    echo "Usage: $0 <usb_device> <poky_image_path>"
    echo "Example: $0 /dev/sdb ~/Downloads/poky-image.iso"
    exit 1
}

# Check arguments
if [ "$#" -ne 2 ]; then
    usage
fi

usb_device="$1"
poky_image_path="$BMR_x86_64_IMAGE_PATH"

# Call the function to create bootable USB
create_bootable_usb "$usb_device" "$poky_image_path"
