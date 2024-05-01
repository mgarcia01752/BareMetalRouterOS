SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "bare-metal-router production image"
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

INIT_MANAGER = "systemd"

IMAGE_INSTALL:append = "python3                 \
                        python3-cmd2            \
                        python3-tabulate        \
                        python3-prettytable     \
                        python3-argcomplete     \
                        python3-beautifulsoup4  \
                        python3-jc"

IMAGE_INSTALL:append = " readline iproute2 iw bash iptables net-tools sudo util-linux"
IMAGE_INSTALL:append = " openssh openssl"
IMAGE_INSTALL:append = " usbutils usbinit"
IMAGE_INSTALL:append = " pciutils"
IMAGE_INSTALL:append = " router-shell"



