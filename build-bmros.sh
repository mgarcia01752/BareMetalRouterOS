#!/usr/bin/env bash

source lib/common.sh

IMAGE_TO_BUILD=${BMR_IMAGE_BB_REF}
BASE_DIR=${PWD}

usage() {
    echo
    echo "Usage: $0 [options]"
    echo "Options:"
    echo
    echo "  -b, --bare-metal-router (default)"
    echo "  -c, --core-image-minimal"
    echo "  -u, --update-meta-bare-metal-router-layer"
    echo
    exit 1
}

update_last_build_recipe() {
  echo -e $1 >> "${BASE_DIR}/.last_build_recipe"
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -b|--bare-metal-router)
            IMAGE_TO_BUILD="${BMR_IMAGE_BB_REF}"
            shift
            ;;
        -c|--core-image-minimal)
            IMAGE_TO_BUILD="${POKY_CORE_IMG_MIN}"
            shift
            ;;
        -u| --update-bare-metal-layer)
            `./update-layers.sh`
            shift
            ;;
        -h|--help)
            usage
            exit
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit
            ;;
    esac
done

start_time=$(get_epoch_timestamp)
display_banner "Building Bare Metal Router"

BASE_DIR=${PWD}
POKY_DIR="${BASE_DIR}/${POKY_DIR_NAME}"

check_directory "$POKY_DIR" || { 
    echo "ERROR: Directory $POKY_DIR not found"
    echo "ERROR: Run: . ${BASE_DIR}/install-poky.sh"
    echo
    exit 1
}

cd "$POKY_DIR" 

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

if [[ -n "$IMAGE_TO_BUILD" ]]; then
    display_banner "Start Bare Metal Router Build: $IMAGE_TO_BUILD"
    bitbake -k $IMAGE_TO_BUILD
    update_last_build_recipe ${IMAGE_TO_BUILD}
fi

if check_directory "${BASE_DIR}/downloads"; then
    echo "Adding ${BASE_DIR}/downloads to reduce time for future build"
    echo "!!!!DO NOT REMOVE!!!! -> ${BASE_DIR}/downloads"
fi

elapsed_time=$(( $(get_epoch_timestamp) - start_time ))

display_banner "BUILD COMPLETE - Build Elapse Time: $elapsed_time seconds"
