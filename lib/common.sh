#!/usr/bin/bash

STATUS_OK=0
STATUS_NOK=1

BMR_BUILD_DIR_NAME="build-bmr"
BMR_IMAGE_BB_REF="bare-metal-router"
POKY_CORE_IMG_MIN="core-image-minimal"

MACHINE_ARCH_x86_64="qemux86-64"

#YOCTO_CODE_NAME="scarthgap"
YOCTO_CODE_NAME="dunfell"

POKY_DIR_NAME="poky"
POKY_BUILD_PATH=${POKY_DIR_NAME}/${build}
BMR_META_LAYERS="yocto-meta-layers"

BMR_x86_64_IMAGE_PATH=${POKY_BUILD_PATH}/tmp/deploy/images/${MACHINE_ARCH_x86_64}
BMR_x86_64_IMAGE_FILENAME="${BMR_IMAGE_BB_REF}-${MACHINE_ARCH_x86_64}.rootfs.ext4"

BB_LAYER_OPEN_EMBEDDED="meta-openembedded"
BB_LAYER_OPEN_EMBEDDED_OE="meta-oe"
BB_LAYER_OPEN_EMBEDDED_PYTHON="meta-python"
BB_LAYER_OPEN_EMBEDDED_NETWORKING="meta-networking"

BB_LAYER_INTEL="meta-intel"
BB_LAYER_BARE_METAL_ROUTER="meta-bare-metal-router"

display_banner() {
  echo "-------------------------------------------------------"
  echo " $1"
  echo "-------------------------------------------------------"
  echo
}

# Function to check if OS is supported
check_os() {
  case "$(lsb_release -si) $(lsb_release -sr)" in
    "Ubuntu 20.04" | "Ubuntu 22.04" | "Debian GNU/Linux 11" | "Debian GNU/Linux 12")
      return ${STATUS_OK} ;;
    "Fedora 38" | "OpenSUSE Leap 15.4" | "AlmaLinux 8" | "AlmaLinux 9" | "Rocky 9")
      return${STATUS_OK};;
    *)
      return${STATUS_NOK};;
  esac
}

# Function to handle errors and exit
handle_error() {
  echo "Error: $1"
  exit 1
}

# Function to display warning
handle_warning() {
  echo "WARNING: $1"
}

# Function to check if a directory exists
check_directory() {
  if [ -d "$1" ]; then
    return ${STATUS_OK}
  else
    return ${STATUS_NOK}
  fi
}

# Function to check if a directory exists, create if not
check_and_create_dir() {
  if [ ! -d "$1" ]; then
    echo "Creating directory: $1"
    mkdir -p "$1"
  fi
}

get_epoch_timestamp() {
  echo $(date +%s)
}

update_last_build_recipe() {
  echo $0 >> .last_build_recipe
}




