#!/usr/bin/bash

# Source the common script
source lib/common.sh

# Default image to build
IMAGE_TO_BUILD=${BMR_IMAGE_BB_REF}

# Function to display usage
usage() {
    echo "Usage: $0 [-m]"
    echo "  -m  Build core-image-minimal"
    echo "  Will build ${BMR_BUILD_DIR_NAME} by default"
    exit 1
}

# Parse command-line options
while getopts ":m" opt; do
    case ${opt} in
        m)
            IMAGE_TO_BUILD="core-image-minimal"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

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
cd "$POKY_DIR" || exit
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
