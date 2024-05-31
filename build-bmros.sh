#!/usr/bin/env bash

source lib/common.sh

IMAGE_TO_BUILD=${BMR_IMAGE_BB_REF}
BASE_DIR=${PWD}

usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo
    echo "  --clean"
    echo "  --clean-all"
    echo "  --clean-all-world"
    echo "  --update-bare-metal-layer"
    echo
    echo "  [-b], [--bare-metal-router] (default)"
    echo "  -c, --core-image-minimal"
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
        --clean)
            CLEAN=true
            # Add code for handling --clean option here
            ## bitbake -c cleanall reciep
            shift
            ;;
        --clean-all)
            CLEANALL=true
            # Add code for handling --clean-all option here
            # bitbake -c cleanall core-image-minimal
            shift
            ;;
        --clean-all-world)
            CLEANALL_WORLD=true
            # bitbake world -c cleanall --continue
            # The --continue will ignore any dependency errors while cleaning. 
            # Continue as much as possible after an error.
            shift
            ;;
        --update-bare-metal-layer)
            `./update-layers.sh`
            shift
            ;;
        -h|--help)
            display_usage
            exit
            ;;
        *)
            echo "Unknown option: $1"
            display_usage
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

cd "$POKY_DIR" || {display_banner "BUILD FAILED"; exit}

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

if [ "${CLEANALL_WORLD}" = true ]; then
    bitbake world -c cleanall --continue ||  {display_banner "BUILD FAILED (clean all world)"; exit 1}
    display_banner "CLEAN COMPLETE"
    exit
fi

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
