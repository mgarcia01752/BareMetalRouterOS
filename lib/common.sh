#!/usr/bin/env bash

STATUS_OK=0
STATUS_NOK=1

BMROS_BUILD_DIR_NAME="build-bmros"
BMROS_IMAGE_BB_REF_PROD="bare-metal-router"
BMROS_IMAGE_BB_REF_VANILLA="bare-metal-router-vanilla"
BMROS_IMAGE_BB_REF_DEBUG="bare-metal-router-debug"
POKY_CORE_IMG_MIN="core-image-minimal"

ROOTFS_WIC_FILENAME_EXT="rootfs.wic"
ROOTFS_EXT4_FILENAME_EXT="rootfs.ext4"

MACHINE_ARCH_x86_64="qemux86-64"

YOCTO_CODE_NAME="scarthgap"

POKY_DIR_NAME="poky"
POKY_BUILD_PATH="${POKY_DIR_NAME}/${BMROS_BUILD_DIR_NAME}"

META_POKY_CONF_PATH="${POKY_DIR_NAME}/meta-poky/conf/distro/poky.conf"

BMROS_META_LAYERS="yocto-meta-layers"
BMROS_x86_64_TMP_DEPLOY_IMAGE_PATH="tmp/deploy/images/${MACHINE_ARCH_x86_64}"
BMROS_x86_64_IMAGE_PATH="${POKY_BUILD_PATH}/${BMROS_x86_64_TMP_DEPLOY_IMAGE_PATH}"
BMROS_x86_64_IMAGE_FILENAME="${BMROS_IMAGE_BB_REF_PROD}-${MACHINE_ARCH_x86_64}.${ROOTFS_EXT4_FILENAME_EXT}"
BMROS_x86_64_WIC_IMAGE_FILENAME="${BMROS_IMAGE_BB_REF_PROD}-${MACHINE_ARCH_x86_64}.${ROOTFS_WIC_FILENAME_EXT}"

BB_LAYER_OPEN_EMBEDDED="meta-openembedded"
BB_LAYER_OPEN_EMBEDDED_OE="meta-oe"
BB_LAYER_OPEN_EMBEDDED_PYTHON="meta-python"
BB_LAYER_OPEN_EMBEDDED_NETWORKING="meta-networking"

BB_LAYER_INTEL="meta-intel"
BB_LAYER_BARE_METAL_ROUTER="meta-bare-metal-router"

display_banner() {
  echo "----------------------------------------------------------------"
  echo " $1"
  echo "----------------------------------------------------------------"
  echo
}

check_build_os() {
  case "$(lsb_release -si) $(lsb_release -sr)" in
    "Ubuntu 20.04" | "Ubuntu 22.04")
      return ${STATUS_OK} ;;
    *)
      return${STATUS_NOK};;
  esac
}

handle_error() {
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e "${RED}Error: $1${NC}"
  exit 1
}

handle_warning() {
  YELLOW='\033[1;33m'
  NC='\033[0m' # No Color
  echo -e "${YELLOW}WARNING: $1${NC}"
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
  local recipe_name="$1"
  
  # Check if recipe name is provided
  if [ -z "$recipe_name" ]; then
    echo "Error: No recipe name provided."
    echo "Usage: update_last_build_recipe <recipe_name>"
    return 1
  fi

  echo "$recipe_name" >> .last_build_recipe
}

get_last_build_recipe() {
  local file=".last_build_recipe"

  # Check if the file exists
  if [ ! -f "$file" ]; then
    echo "Error: .last_build_recipe file not found."
    return 1
  fi

  # Get the last entry in the file
  local last_recipe=$(tail -n 1 "$file")

  # Check if the file is empty
  if [ -z "$last_recipe" ]; then
    echo "Error: .last_build_recipe file is empty."
    return 1
  fi

  echo "${last_recipe}  "
}

check_file() {
    [ -f "$1" ] || handle_error "Failed to find: $1"
    echo
}

