#!/usr/bin/bash

source lib/common.sh

BUILD_DIR=${PWD}
POKY_DIR="${BUILD_DIR}/${POKY_DIR_NAME}"
INSTALL_POKY_ONLY=false  # Default value

# Function to display usage
display_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --install-poky    Install Poky only"
    exit 1
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -p|--install-poky)
        INSTALL_POKY_ONLY=true
        shift
        ;;
        -h|--help)
        display_usage
        ;;
        *)
        echo "Unknown option: $1"
        display_usage
        ;;
    esac
done

display_banner "INSTALL BARE METAL ROUTER (BMR)"

# Check if Poky directory already exists
display_banner "Setting up Yocto Directories"
if check_directory "${POKY_DIR}"; then
  echo "Poky directory already exists."
else
  echo "Cloning Yocto Poky repository (${YOCTO_CODE_NAME})..."
  git clone --single-branch --branch ${YOCTO_CODE_NAME} https://git.yoctoproject.org/git/poky "${POKY_DIR}" || handle_error "Failed to clone Poky repository."
  cd "${POKY_DIR}"
  git pull || handle_error "Failed to pull updates from Poky repository."
fi
echo "Yocto Poky directory set up successfully."
echo

if [ "$INSTALL_POKY_ONLY" = true ]; then
    echo "Installed Poky only. Exiting."
    exit 0
fi

# Check if external layers directory already exists
EXTERNAL_LAYERS_DIR="${POKY_DIR}/sources"
META_INTEL_DIR="${EXTERNAL_LAYERS_DIR}/meta-intel"

if check_directory "${EXTERNAL_LAYERS_DIR}"; then
  echo "External layers directory already exists."
else
  display_banner "Cloning meta-intel layer"
  mkdir -p "${EXTERNAL_LAYERS_DIR}" || handle_error "Failed to create external layers directory."
  cd "${EXTERNAL_LAYERS_DIR}"
  git clone --single-branch --branch ${YOCTO_CODE_NAME} git://git.yoctoproject.org/meta-intel "${META_INTEL_DIR}" || handle_error "Failed to clone meta-intel layer."
  cp -r ${META_INTEL_DIR}  ${POKY_DIR}
fi
cd ${POKY_DIR}
echo "External layers set up successfully."
echo

display_banner "Installing meta-bare-metal-router Layer"
BMR_INSTALL_SRC_DIR=${BUILD_DIR}/yocto-meta-layers
if [ -d "${BMR_INSTALL_SRC_DIR}" ]; then
  cp -r "${BMR_INSTALL_SRC_DIR}/meta-bare-metal-router" "${POKY_DIR}" || handle_error "Failed to copy meta-bare-metal-router layer."
  echo "meta-bare-metal-router layer installed successfully."
else
  echo "cp -r ${BMR_INSTALL_SRC_DIR}/meta-bare-metal-router ${POKY_DIR}"
  handle_error "Path to meta-bare-metal-router layer is invalid."
fi

display_banner "Setting Up Yocto Build Environment"
cd ${POKY_DIR}
source "${POKY_DIR}/oe-init-build-env" "${BMR_BUILD_DIR_NAME}"
echo "Yocto build environment set up successfully."
echo

display_banner "Adding Required Layers"
bitbake-layers add-layer ../meta-intel
echo "Adding meta-intel"

bitbake-layers add-layer ../meta-bare-metal-router
echo "Adding meta-bare-metal-router"

echo "Updating local.conf"
cat <<EOF >> "${POKY_DIR}/${BMR_BUILD_DIR_NAME}/conf/local.conf"
PARALLEL_MAKE = "-j 8"
IMAGE_FEATURES += "tools-sdk"
IMAGE_FSTYPES += "iso"
EOF

echo "DL_DIR = \"${BUILD_DIR}/downloads\"" >> "${POKY_DIR}/${BMR_BUILD_DIR_NAME}/conf/local.conf"

display_banner "INSTALLATION COMPLETE"
