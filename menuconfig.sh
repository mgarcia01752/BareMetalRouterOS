#!/usr/bin/env bash

source lib/common.sh

function usage() {
    echo "Usage: $0 [-k|--kernel] [-b|--busybox] [-u|--u-boot]"
    echo "Options:"
    echo "  -k, --kernel    Run Kernel menuconfig"
    echo "  -b, --busybox   Run BusyBox menuconfig"
    echo "  -u, --u-boot    Run U-Boot menuconfig"
    exit 1
}

error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Ensure required environment variables are set
[ -z "$POKY_DIR_NAME" ] && error_exit "POKY_DIR_NAME is not set."
[ -z "$BMROS_BUILD_DIR_NAME" ] && error_exit "BMROS_BUILD_DIR_NAME is not set."

# Parse command line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -k|--kernel)
            MENU="kernel"
            shift
            ;;
        -b|--busybox)
            MENU="busybox"
            shift
            ;;
        -u|--u-boot)
            MENU="u-boot"
            shift
            ;;
        *)
            usage
            ;;
    esac
done

if [ -z "$MENU" ]; then
    usage
fi

START_DIR=$(pwd)

cd "$POKY_DIR_NAME" || error_exit "Failed to change directory to $POKY_DIR_NAME"

display_banner "Starting $MENU MenuConfig"

source oe-init-build-env "$BMROS_BUILD_DIR_NAME" || error_exit "Failed to source oe-init-build-env"

case $MENU in
    kernel)
        bitbake virtual/kernel -c menuconfig || error_exit "Failed to run bitbake virtual/kernel -c menuconfig"
        ;;
    busybox)
        bitbake busybox -c menuconfig || error_exit "Failed to run bitbake busybox -c menuconfig"
        ;;
    u-boot)
        bitbake u-boot -c menuconfig || error_exit "Failed to run bitbake u-boot -c menuconfig"
        ;;
    *)
        usage
        ;;
esac

cd "$START_DIR" || error_exit "Failed to return to the starting directory"

display_banner "$MENU MenuConfig Completed"
