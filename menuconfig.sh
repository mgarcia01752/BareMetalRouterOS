#!/usr/bin/env bash

source lib/common.sh

function usage() {
    echo "Usage: $0 [-b|--busybox] [-k|--kernel] [-u|--u-boot]"
    echo "Options:"
    echo "  -b, --busybox   Run BusyBox menuconfig"    
    echo "  -k, --kernel    Run Kernel menuconfig"
    echo "  -u, --u-boot    Run U-Boot menuconfig"
    exit 1
}

error_exit() {
    echo "Error: $1" >&2
    exit 1
}

[ -z "$POKY_DIR_NAME" ] && error_exit "POKY_DIR_NAME is not set."
[ -z "$BMROS_BUILD_DIR_NAME" ] && error_exit "BMROS_BUILD_DIR_NAME is not set."

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

copy_config_files() {
    local config_file=$1
    local target_dir=$2
    display_banner "Copying $MENU config to $target_dir"
    cp "$config_file" "../../$BMROS_META_LAYERS/$target_dir" || error_exit "Failed to copy $MENU config"
}

case $MENU in
    kernel)
        bmros_linux_recipe="${BB_LAYER_BARE_METAL_ROUTER}/recipes-kernel/linux/files"
        bitbake virtual/kernel -c menuconfig || error_exit "Failed to run bitbake virtual/kernel -c menuconfig"
        bitbake virtual/kernel -c diffconfig || error_exit "Failed to run bitbake busybox -c diffconfig"
        kernel_config_file=$(find . -regex '.*/linux-qemux86_64-standard-build/.config')
        copy_config_files "$kernel_config_file" "$bmros_linux_recipe"
        ;;
    busybox)
        bmros_busybox_recipe="${BB_LAYER_BARE_METAL_ROUTER}/recipes-core/busybox/files"
        bitbake busybox -c menuconfig || error_exit "Failed to run bitbake busybox -c menuconfig"
        bitbake busybox -c diffconfig || error_exit "Failed to run bitbake busybox -c diffconfig"
        busybox_config_file=$(find . -regex '.*/busybox-[0-9]+\(\.[0-9]+\)+/.config')
        copy_config_files "$busybox_config_file" "$bmros_busybox_recipe"
        ;;
    u-boot)
        bitbake u-boot -c menuconfig || error_exit "Failed to run bitbake u-boot -c menuconfig"
        bitbake u-boot -c diffconfig || error_exit "Failed to run bitbake u-boot -c diffconfig"
        ;;
    *)
        usage
        ;;
esac

cd "$START_DIR" || error_exit "Failed to return to the starting directory"

display_banner "$MENU MenuConfig Completed"
