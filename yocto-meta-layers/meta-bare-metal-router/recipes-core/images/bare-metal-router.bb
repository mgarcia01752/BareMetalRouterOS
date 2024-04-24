SUMMARY = "Bare Metal Router"
DESCRIPTION = "bare-metal-router production image"
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = " python3 iw openssh openssl bash iptables pciutils usbinit net-tools sudo"
