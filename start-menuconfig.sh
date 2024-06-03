#!/usr/bin/env bash

source lib/common.sh

error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Ensure required environment variables are set
[ -z "$POKY_DIR_NAME" ] && error_exit "POKY_DIR_NAME is not set."
[ -z "$BMROS_BUILD_DIR_NAME" ] && error_exit "BMROS_BUILD_DIR_NAME is not set."

START_DIR=$(pwd)

cd "$POKY_DIR_NAME" || error_exit "Failed to change directory to $POKY_DIR_NAME"

display_banner "Starting Kernel MenuConfig"

source oe-init-build-env "$BMROS_BUILD_DIR_NAME" || error_exit "Failed to source oe-init-build-env"

bitbake virtual/kernel -c menuconfig || error_exit "Failed to run bitbake virtual/kernel -c menuconfig"

cd "$START_DIR" || error_exit "Failed to return to the starting directory"

display_banner "Kernel MenuConfig Completed"
