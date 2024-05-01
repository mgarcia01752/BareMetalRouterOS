SUMMARY = "Bare Metal Router"
DESCRIPTION = "bare-metal-router production image"
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = "python3 \
                        python3-cmd2 \
                        python3-tabulate \
                        python3-prettytable \
                        python3-argcomplete "
                        
IMAGE_INSTALL:append = " iw bash iptables net-tools sudo util-linux"
IMAGE_INSTALL:append = " openssh openssl"
IMAGE_INSTALL:append = " usbutils usbinit"
IMAGE_INSTALL:append = " pciutils"
IMAGE_INSTALL:append = " router-shell"



