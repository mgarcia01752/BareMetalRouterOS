#!/usr/bin/env bash

source lib/common.sh

if [ "$(id -u)" -eq 0 ]; then
    echo "This script must not be run as root or with sudo." >&2
    exit 1
fi

BMROS_GIT_DIR=${PWD}
POKY_DIR="${BMROS_GIT_DIR}/${POKY_DIR_NAME}"
BMROS_VERSION_FILE="${BMROS_GIT_DIR}/VERSION"
INSTALL_POKY_ONLY=false
YOCTO_BITBAKE_GIT_DISTRO="https://git.openembedded.org/bitbake"
YOCTO_OPENEMBEDDED_CORE_GIT_DISTRO="https://git.openembedded.org/openembedded-core"
YOCTO_META_YOCTO_GIT_DISTRO="https://git.yoctoproject.org/meta-yocto"
YOCTO_META_OPENEMBEDDED_GIT_DISTRO="https://git.openembedded.org/meta-openembedded"
LAYERS_DIR="${POKY_DIR}/layers"

display_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -p, --install-poky       Install Poky only"
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

clone_or_check_repo() {
  local repo_url="$1"
  local repo_ref="$2"
  local repo_dir="$3"
  local repo_name="$4"

  if check_directory "${repo_dir}"; then
    echo "${repo_name} directory already exists."
    current_branch="$(git -C "${repo_dir}" rev-parse --abbrev-ref HEAD)"
    current_tag="$(git -C "${repo_dir}" describe --tags --exact-match HEAD 2>/dev/null || true)"
    if [[ "${current_branch}" != "${repo_ref}" && "${current_tag}" != "${repo_ref}" ]]; then
      handle_error "Existing ${repo_name} checkout is on branch '${current_branch}' tag '${current_tag}', expected '${repo_ref}'. Remove ${repo_dir} and rerun this script."
    fi
  else
    echo "Cloning ${repo_name} (${repo_ref})..."
    git clone --single-branch --branch "${repo_ref}" "${repo_url}" "${repo_dir}" || handle_error "Failed to clone ${repo_name}."
  fi
}

#####################################################################################
display_banner "Install BMROS (BARE METAL ROUTER OS)"
check_file "${BMROS_VERSION_FILE}"
BMROS_DISTRO_VERSION="$(cat "${BMROS_VERSION_FILE}")"

#####################################################################################
display_banner "Fetching Yocto Poky Directories"

mkdir -p "${LAYERS_DIR}" || handle_error "Failed to create layers directory."
clone_or_check_repo "${YOCTO_BITBAKE_GIT_DISTRO}" "${YOCTO_RELEASE_REF}" "${LAYERS_DIR}/bitbake" "BitBake"
clone_or_check_repo "${YOCTO_OPENEMBEDDED_CORE_GIT_DISTRO}" "${YOCTO_RELEASE_REF}" "${LAYERS_DIR}/openembedded-core" "OpenEmbedded-Core"
clone_or_check_repo "${YOCTO_META_YOCTO_GIT_DISTRO}" "${YOCTO_RELEASE_REF}" "${LAYERS_DIR}/meta-yocto" "meta-yocto"

echo "Yocto Poky directory set up successfully."
echo

if [ "${INSTALL_POKY_ONLY}" = true ]; then
    echo "Installed Poky source layers only. Exiting."
    exit 0
fi

#####################################################################################
display_banner "Rename Poky to BMROS (Bare Metal Router OS)"

POKY_CONF="${BMROS_GIT_DIR}/${META_POKY_CONF_PATH}"

check_file ${POKY_CONF} 

NEW_LINE1='DISTRO = "bmros"'
NEW_LINE2='DISTRO_NAME = "BMROS (Bare Metal Router OS Distro)"'
NEW_LINE3="DISTRO_VERSION = \"${BMROS_DISTRO_VERSION}\""

# Use sed to perform the replacement
sed -i -e "s|^DISTRO = .*|${NEW_LINE1}|" \
       -e "s|^DISTRO_NAME = .*|${NEW_LINE2}|" \
       -e "s|^DISTRO_VERSION = .*|${NEW_LINE3}|" "${POKY_CONF}"

echo "Created: BMROS (Bare Metal Router OS Distro)"
echo
cd ${POKY_DIR}

META_OPEN_EMBEDDED_DIR="${LAYERS_DIR}/meta-openembedded"
clone_or_check_repo "${YOCTO_META_OPENEMBEDDED_GIT_DISTRO}" "${YOCTO_CODE_NAME}" "${META_OPEN_EMBEDDED_DIR}" "${BB_LAYER_OPEN_EMBEDDED}"

#####################################################################################

cd ${POKY_DIR}
echo "${BB_LAYER_OPEN_EMBEDDED} layer set up successfully."
echo "${BB_LAYER_PYTHON} layer set up successfully."
echo

#####################################################################################
display_banner "Installing ${BB_LAYER_BARE_METAL_ROUTER} Layer"

BMROS_INSTALL_SRC_DIR=${BMROS_GIT_DIR}/yocto-meta-layers
if [ -d "${BMROS_INSTALL_SRC_DIR}" ]; then
  rm -rf "${LAYERS_DIR}/${BB_LAYER_BARE_METAL_ROUTER}"
  cp -r "${BMROS_INSTALL_SRC_DIR}/${BB_LAYER_BARE_METAL_ROUTER}" "${LAYERS_DIR}" || handle_error "Failed to copy ${BB_LAYER_BARE_METAL_ROUTER} layer."
  echo "${BB_LAYER_BARE_METAL_ROUTER} layer installed successfully."

else
  echo "cp -r ${BMROS_INSTALL_SRC_DIR}/${BB_LAYER_BARE_METAL_ROUTER} ${POKY_DIR}"
  handle_error "Path to ${BB_LAYER_BARE_METAL_ROUTER} layer is invalid."

fi

display_banner "Setting Up Yocto BMROS Build Environment"

cd ${POKY_DIR}

source "layers/openembedded-core/oe-init-build-env" ${BMROS_BUILD_DIR_NAME} || handle_error "Failed to create build directory: ${BMROS_BUILD_DIR_NAME}"
echo "Yocto build environment set up successfully."
echo

#####################################################################################
display_banner "Adding Required Layers"

bitbake-layers add-layer ../layers/meta-yocto/meta-poky
echo "Adding meta-poky"

bitbake-layers add-layer ../layers/${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_OE}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_OE}"

bitbake-layers add-layer ../layers/${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_PYTHON}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_PYTHON}"

bitbake-layers add-layer ../layers/${BB_LAYER_OPEN_EMBEDDED}/${BB_LAYER_OPEN_EMBEDDED_NETWORKING}
echo "Adding ${BB_LAYER_OPEN_EMBEDDED_NETWORKING}"

bitbake-layers add-layer ../layers/${BB_LAYER_BARE_METAL_ROUTER}
echo "Adding ${BB_LAYER_BARE_METAL_ROUTER}"

echo "Updating ${BMROS_BUILD_DIR_NAME}/conf/local.conf"
cat <<EOF >> "${POKY_DIR}/${BMROS_BUILD_DIR_NAME}/conf/local.conf"
PARALLEL_MAKE = "-j 8"
# DISTRO_FEATURES:append = " systemd usrmerge "
# DISTRO_FEATURES_BACKFILL_CONSIDERED += "sysvinit"
# VIRTUAL-RUNTIME_init_manager = "systemd"
# VIRTUAL-RUNTIME_initscripts = "systemd-compat-units"
IMAGE_FSTYPES += "wic wic.bmap"
EOF

echo "DL_DIR = \"${BMROS_GIT_DIR}/downloads\"" >> "${POKY_DIR}/${BMROS_BUILD_DIR_NAME}/conf/local.conf"

display_banner "Bare Metal Router OS Distrubution Installation Complete"
