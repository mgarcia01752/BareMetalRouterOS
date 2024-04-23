#!/usr/bin/bash

BMR_BUILD_DIR_NAME="build-bmr"
BMR_IMAGE_BB_REF="bare-metal-router"

MACHINE_ARCH_x86_64="qemux86-64"

YOCTO_CODE_NAME="scarthgap"
POKY_DIR_NAME="poky"
POKY_BUILD_PATH=${POKY_DIR_NAME}/${build}
BMR_META_LAYERS="yocto-meta-layers"

BMR_x86_64_IMAGE_PATH=${POKY_BUILD_PATH}/tmp/deploy/images/${MACHINE_ARCH_x86_64}
BMR_x86_64_IMAGE_FILENAME="${BMR_IMAGE_BB_REF}-${MACHINE_ARCH_x86_64}.rootfs.ext4"

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
      return 0 ;; # Supported OS
    "Fedora 38" | "OpenSUSE Leap 15.4" | "AlmaLinux 8" | "AlmaLinux 9" | "Rocky 9")
      return 0 ;; # Supported OS
    *)
      return 1 ;; # Unsupported OS
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
    return 0  # Directory exists
  else
    return 1  # Directory does not exist
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
  return `date +%s`
}
