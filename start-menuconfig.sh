#!/usr/bin/env bash

# Source common functions and variables
source lib/common.sh

# Function to display an error message and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Ensure required environment variables are set
[ -z "$POKY_DIR_NAME" ] && error_exit "POKY_DIR_NAME is not set."
[ -z "$BMR_BUILD_DIR_NAME" ] && error_exit "BMR_BUILD_DIR_NAME is not set."

# Store the current directory
START_DIR=$(pwd)

# Change to the Poky directory
cd "$POKY_DIR_NAME" || error_exit "Failed to change directory to $POKY_DIR_NAME"

# Display banner message
display_banner "Starting Kernel MenuConfig"

# Source the build environment script
source oe-init-build-env "$BMR_BUILD_DIR_NAME" || error_exit "Failed to source oe-init-build-env"

# Run menuconfig
bitbake virtual/kernel -c menuconfig || error_exit "Failed to run bitbake virtual/kernel -c menuconfig"

# Optionally, return to the starting directory
cd "$START_DIR" || error_exit "Failed to return to the starting directory"

# Script end
display_banner "Kernel MenuConfig Completed"
