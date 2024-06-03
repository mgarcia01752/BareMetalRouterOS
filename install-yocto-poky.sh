#!/usr/bin/env bash

source lib/common.sh

BMROS_GIT_DIR=${PWD}
POKY_DIR="${BMROS_GIT_DIR}/${POKY_DIR_NAME}"
INSTALL_POKY_ONLY=false
YOCTO_POKY_GIT_DISTRO="https://git.yoctoproject.org/git/poky"
YOCTO_META_INTEL_GIT_DISTRO="git://git.yoctoproject.org/meta-intel"

display_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --install-poky    Install Poky only"
    exit 1
}

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

#####################################################################################
display_banner "Install BMROS (BARE METAL ROUTER OS)"

#####################################################################################
display_banner "Fetching Yocto Poky Directories"

if check_directory "${POKY_DIR}"; then
  echo "Poky directory already exists."

else
  echo "Cloning Yocto Poky repository (${YOCTO_CODE_NAME})..."
  git clone --single-branch --branch ${YOCTO_CODE_NAME} ${YOCTO_POKY_GIT_DISTRO} "${POKY_DIR}" || handle_error "Failed to clone Poky repository."
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
META_INTEL_DIR="${EXTERNAL_LAYERS_DIR}/${BB_LAYER_INTEL}"

if check_directory "${META_INTEL_DIR}"; then
  echo "External layers directory already exists."

else
  display_banner "Cloning ${BB_LAYER_INTEL} layer"
  mkdir -p "${EXTERNAL_LAYERS_DIR}" || handle_error "Failed to create external layers directory."
  cd "${EXTERNAL_LAYERS_DIR}"
  git clone --single-branch --branch ${YOCTO_CODE_NAME} ${YOCTO_META_INTEL_GIT_DISTRO} "${META_INTEL_DIR}" || handle_error "Failed to clone meta-intel layer."
  cp -r ${META_INTEL_DIR}  ${POKY_DIR}

fi

echo "${BB_LAYER_INTEL} layer set up successfully."
echo

#####################################################################################
display_banner "Rename Poky to BMROS (Bare Metal Router OS)"

POKY_CONF="${BMROS_GIT_DIR}/${META_POKY_CONF_PATH}"

check_file ${POKY_CONF} 

# Define the lines to search for and their replacements
OLD_LINE1='DISTRO = "poky"'
OLD_LINE2='DISTRO_NAME = "Poky (Yocto Project Reference Distro)"'
OLD_LINE3='DISTRO_VERSION = "5.0.1"'

NEW_LINE1='DISTRO = "bmros"'
NEW_LINE2='DISTRO_NAME = "BMROS (Bare Metal Router OS Distro)"'
NEW_LINE3='DISTRO_VERSION = "0.1.0"'

# Use sed to perform the replacement
sed -i -e "s|^${OLD_LINE2}$|${NEW_LINE2}|" \
       -e "s|^${OLD_LINE3}$|${NEW_LINE3}|" "${POKY_CONF}"

echo "Created: BMROS (Bare Metal Router OS Distro)"
echo
cd ${POKY_DIR}

META_OPEN_EMBEDDED_DIR="${EXTERNAL_LAYERS_DIR}/meta-openembedded"

if check_directory "${META_OPEN_EMBEDDED_DIR}"; then
  echo "External layers directory (${META_OPEN_EMBEDDED_DIR}) already exists."

else
  display_banner "Cloning ${BB_LAYER_OPEN_EMBEDDED}"
  mkdir -p "${EXTERNAL_LAYERS_DIR}" || handle_error "Failed to create external layers directory."
  cd "${EXTERNAL_LAYERS_DIR}"
  git clone git://git.openembedded.org/${BB_LAYER_OPEN_EMBEDDED} -b ${YOCTO_CODE_NAME}  || handle_error "Failed to clone ${BB_LAYER_OPEN_EMBEDDED} layer."
  cp -r ${BB_LAYER_OPEN_EMBEDDED}  ${POKY_DIR}

fi

#####################################################################################

cd ${POKY_DIR}
echo "${BB_LAYER_OPEN_EMBEDDED} layer set up successfully."
echo "${BB_LAYER_PYTHON} layer set up successfully."
echo

#####################################################################################
display_banner "Installing ${BB_LAYER_BARE_METAL_ROUTER} Layer"

BMROS_INSTALL_SRC_DIR=${BMROS_GIT_DIR}/yocto-meta-layers
if [ -d "${BMROS_INSTALL_SRC_DIR}" ]; then
  cp -r "${BMROS_INSTALL_SRC_DIR}/${BB_LAYER_BARE_METAL_ROUTER}" "${POKY_DIR}" || handle_error "Failed to copy ${BB_LAYER_BARE_METAL_ROUTER} layer."
  echo "${BB_LAYER_BARE_METAL_ROUTER} layer installed successfully."

else
  echo "cp -r ${BMROS_INSTALL_SRC_DIR}/${BB_LAYER_BARE_METAL_ROUTER} ${POKY_DIR}"
  handle_error "Path to ${BB_LAYER_BARE_METAL_ROUTER} layer is invalid."

fi

display_banner "Setting Up Yocto BMROS Build Environment"

cd ${POKY_DIR}

source oe-init-build-env ${BMROS_BUILD_DIR_NAME} || handle_error "Failed to create build directory: ${BMROS_BUILD_DIR_NAME}"
echo "Yocto build environment set up successfully."
echo

#####################################################################################
display_banner "Adding Required Layers"

bitbake-layers add-layer ../${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_OE}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_OE}"

bitbake-layers add-layer ../${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_PYTHON}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_PYTHON}"

bitbake-layers add-layer ../${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_NETWORKING}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_NETWORKING}"

bitbake-layers add-layer ../${BB_LAYER_INTEL}
echo "Adding ${BB_LAYER_INTEL}"

bitbake-layers add-layer ../${BB_LAYER_BARE_METAL_ROUTER}
echo "Adding ${BB_LAYER_BARE_METAL_ROUTER}"

echo "Updating ${BMROS_BUILD_DIR_NAME}/conf/local.conf"
cat <<EOF >> "${POKY_DIR}/${BMROS_BUILD_DIR_NAME}/conf/local.conf"
PARALLEL_MAKE = "-j 8"
DISTRO_FEATURES:append = " systemd usrmerge"
DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
VIRTUAL-RUNTIME_init_manager = "systemd"
VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
IMAGE_FSTYPES += "wic wic.bmap"
EOF

echo "DL_DIR = \"${BMROS_GIT_DIR}/downloads\"" >> "${POKY_DIR}/${BMROS_BUILD_DIR_NAME}/conf/local.conf"


display_banner "Bare Metal Router OS Distrubution Installation Complete"