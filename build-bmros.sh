#!/usr/bin/env bash

source lib/common.sh

IMAGE_TO_BUILD=${BMROS_IMAGE_BB_REF_PROD}
BASE_DIR=${PWD}

usage() {
    echo
    echo "Usage: $0 [options]"
    echo "Options:"
    echo
    echo "  -c, --${POKY_CORE_IMG_MIN}"    
    echo -e "  -b, --${BMROS_IMAGE_BB_REF_PROD}\t\t(Production)"
    echo -e "  -d, --${BMROS_IMAGE_BB_REF_DEBUG}\t\t(Debug)"      
    echo -e "  -v, --${BMROS_IMAGE_BB_REF_VANILLA}\t(Non-Debug)"
    echo      
    echo "  -u, --update-poky-meta-bare-metal-router-layer-only"
    echo "  -r, --remove-update-poky-meta-bare-metal-router-layer"
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
            IMAGE_TO_BUILD="${BMROS_IMAGE_BB_REF_PROD}"
            shift
            ;;

        -v|--bare-metal-router-vanilla)
            IMAGE_TO_BUILD="${BMROS_IMAGE_BB_REF_VANILLA}"
            shift
            ;;

        -d|--bare-metal-router-dev)
            IMAGE_TO_BUILD="${BMROS_IMAGE_BB_REF_DEBUG}"
            shift
            ;;            

        -c|--core-image-minimal)
            IMAGE_TO_BUILD="${POKY_CORE_IMG_MIN}"
            shift
            ;;

        -u|--update-bare-metal-layer-only)
            `./update-layers.sh`
            shift
            ;;

        -r|--remove-update-poky-meta-bare-metal-router-layer)
            
            echo
            echo "Are you sure you want to remove directories?"
            echo " * poky/meta-bare-metal-router" 
            echo " * poky/build-bmros/tmp"
            echo
            read -p "(y/n): " confirm

            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                rm -rf poky/meta-bare-metal-router
                rm -rf poky/build-bmros/tmp

            else
                echo "Removal of 'poky/meta-bare-metal-router' directory canceled."
                exit 1
            fi
            
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
display_banner "Building ${IMAGE_TO_BUILD}"

BASE_DIR=${PWD}
POKY_DIR="${BASE_DIR}/${POKY_DIR_NAME}"

check_directory "$POKY_DIR" || { 
    echo "ERROR: Directory $POKY_DIR not found"
    echo "ERROR: Run: . ${BASE_DIR}/install-yocto-poky.sh"
    echo
    exit 1
}

cd "$POKY_DIR" 

source oe-init-build-env ${BMROS_BUILD_DIR_NAME}

if [[ -n "$IMAGE_TO_BUILD" ]]; then
    display_banner "Start Build: $IMAGE_TO_BUILD"
    bitbake -k $IMAGE_TO_BUILD || handle_error "Build ${IMAGE_TO_BUILD} Failed"
    update_last_build_recipe ${IMAGE_TO_BUILD}
fi

if check_directory "${BASE_DIR}/downloads"; then
    echo "Adding ${BASE_DIR}/downloads to reduce time for future build"
    echo "!!!!DO NOT REMOVE!!!! -> ${BASE_DIR}/downloads"
fi

elapsed_time=$(( $(get_epoch_timestamp) - start_time ))

display_banner "BUILD COMPLETE - Build Elapse Time: $elapsed_time seconds"
