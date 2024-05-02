SUMMARY = "RouterShell"
DESCRIPTION = "RouterShell is an open-source IOS-like CLI distribution in Python 3"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://github.com/mgarcia01752/RouterShell.git;protocol=https;branch=yocto-bmr"

PV = "1.0+git"
SRCREV = "908c6d330d7ab53b06bcee40f2078166b7fba622"

DEPENDS += "python3                 \
            python3-cmd2            \
            python3-tabulate        \
            python3-prettytable     \
            python3-argcomplete     \
            python3-beautifulsoup4  \
            python3-jc  "
    
DEPENDS += " readline iproute2 iw bash iptables net-tools sudo util-linux openssl usbutils usbinit pciutils"
DEPENDS += " hostapd ethtool bridge-utils dnsmasq"

RDEPENDS:${PN} += "bash"

S = "${WORKDIR}/git"

FILES:${PN} += "${sysconfdir}/routershell"

do_install() {

    install -d ${D}${sysconfdir}/routershell
    install -m 0766 ${S}/start.sh ${D}${sysconfdir}/routershell/routershell_start.sh

    install -d ${D}${sysconfdir}/routershell/config
    cp -r ${S}/config/* ${D}${sysconfdir}/routershell/config

    install -d ${D}${sysconfdir}/routershell/lib
    cp -r ${S}/lib/* ${D}${sysconfdir}/routershell/lib

    install -d ${D}${sysconfdir}/routershell/lib/cli
    cp -r ${S}/lib/cli/* ${D}${sysconfdir}/routershell/lib/cli

    install -d ${D}${sysconfdir}/routershell/lib/common
    cp -r ${S}/lib/common/* ${D}${sysconfdir}/routershell/lib/common

    install -d ${D}${sysconfdir}/routershell/lib/db
    cp -r ${S}/lib/db/* ${D}${sysconfdir}/routershell/lib/db

    install -d ${D}${sysconfdir}/routershell/lib/hardware
    cp -r ${S}/lib/hardware/* ${D}${sysconfdir}/routershell/lib/hardware

    install -d ${D}${sysconfdir}/routershell/lib/network_manager
    cp -r ${S}/lib/network_manager/* ${D}${sysconfdir}/routershell/lib/network_manager

    install -d ${D}${sysconfdir}/routershell/lib/network_services
    cp -r ${S}/lib/network_services/* ${D}${sysconfdir}/routershell/lib/network_services

    install -d ${D}${sysconfdir}/routershell/lib/system
    cp -r ${S}/lib/system/* ${D}${sysconfdir}/routershell/lib/system

    install -d ${D}${sysconfdir}/routershell/src
    cp -r ${S}/src/* ${D}${sysconfdir}/routershell/src
}



