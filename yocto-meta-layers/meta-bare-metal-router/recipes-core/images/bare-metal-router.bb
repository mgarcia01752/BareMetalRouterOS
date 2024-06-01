SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Production Image"
LICENSE = "MIT"

# Include the core-image-minimal recipe
require recipes-core/images/core-image-minimal.bb

# Include the update-passwd recipe
require recipes-core/update-passwd/update-passwd.bb

# Additional packages to be installed in the image
IMAGE_INSTALL:append = " \
    router-shell \
    bash \
    python3 python3-pygments python3-prompt-toolkit python3-tabulate python3-prettytable python3-beautifulsoup4 python3-jc \
    iproute2 lshw iw iptables net-tools sudo util-linux openssl usbutils usbinit pciutils ethtool bridge-utils \
    hostapd dnsmasq \
    telnetd \
"
