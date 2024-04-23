#!/usr/bin/bash

# Source the common script
source lib/common.sh

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo
    echo "  --clean"
    echo "  --clean-all"
    echo
    echo "  -b, --bare-metal-router"
    echo "  -c, --core-image-minimal"
    exit 1
}

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -b|--bare-metal-router)
            IMAGE_TO_BUILD="${BMR_IMAGE_BB_REF:-(default)}"
            shift
            ;;
        -c|--core-image-minimal)
            IMAGE_TO_BUILD="${POKY_CORE_IMG_MIN}"
            shift
            ;;
        --clean)
            # Add code for handling --clean option here
            shift
            ;;
        --clean-all)
            # Add code for handling --clean-all option here
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


# Display banner
display_banner "Building Bare Metal Router"

BASE_DIR=${PWD}
POKY_DIR="${BASE_DIR}/${POKY_DIR_NAME}"

# Check if POKY_DIR exists, exit with error if not found
check_directory "$POKY_DIR" || { 
    echo "ERROR: Directory $POKY_DIR not found"
    echo "ERROR: Run: . ${BASE_DIR}/install-poky.sh"
    echo
    exit 1
}

# Change to POKY_DIR and source environment
cd "$POKY_DIR" || {display_banner "BUILD FAILED"; exit}

source oe-init-build-env ${BMR_BUILD_DIR_NAME}

# Build selected image if specified
if [[ -n "$IMAGE_TO_BUILD" ]]; then
    display_banner "Start Bare Metal Router Build: $IMAGE_TO_BUILD"
    bitbake -k $IMAGE_TO_BUILD
fi

# Copy build downloads to base directory for quicker re-build
# mkdir -p "${BASE_DIR}/downloads" "${POKY_BUILD_PATH}/downloads"
# cp -r "${POKY_BUILD_PATH}/downloads/"* "${BASE_DIR}/downloads"

# Display completion message
display_banner "BUILD COMPLETE"
