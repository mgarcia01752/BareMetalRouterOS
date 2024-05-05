SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "bare-metal-router production image"
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = " \
    router-shell \
    python3 python3-pygments python3-prompt-toolkit python3-tabulate python3-prettytable python3-beautifulsoup4 python3-jc \
    iproute2 iw bash iptables net-tools sudo util-linux openssl usbutils usbinit pciutils hostapd ethtool bridge-utils dnsmasq \
"
