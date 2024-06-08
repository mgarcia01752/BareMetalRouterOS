SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Production Image"
LICENSE = "MIT"

require recipes-core/images/core-image-minimal.bb

IMAGE_INSTALL:append = "router-shell bash "
IMAGE_INSTALL:append = "python3 python3-pygments python3-prompt-toolkit python3-tabulate python3-prettytable python3-beautifulsoup4 python3-jc "
IMAGE_INSTALL:append = "iproute2 lshw iw iptables sudo util-linux openssl usbutils usbinit pciutils ethtool "
IMAGE_INSTALL:append = "hostapd openssh dnsmasq telnetd "
