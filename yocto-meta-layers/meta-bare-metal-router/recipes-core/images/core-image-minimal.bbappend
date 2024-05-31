SUMMARY = "bitbake-layers recipe"
DESCRIPTION = "core-image-minimal"
LICENSE = "MIT"

INIT_MANAGER = "systemd"
IMAGE_INSTALL:append = " packagegroup-core-boot packagegroup-base-networking"
