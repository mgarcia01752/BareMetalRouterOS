SUMMARY = "RouterShell"
DESCRIPTION = "RouterShell is an open-source IOS-like CLI distribution in Python 3"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

RS_SRC_REV = "0.1.6"
SRCREV = "6bcd7fb6ae2e523d2b6fd69c5b355df05813514a"

PV = "${RS_SRC_REV}+git${SRCPV}"
SRC_URI = "git://github.com/mgarcia01752/RouterShell.git;protocol=https;branch=v${RS_SRC_REV};rev=${SRCREV} "
SRC_URI += "file://router-shell.sh"

DEPENDS += "python3 python3-pygments python3-prompt-toolkit python3-tabulate python3-prettytable python3-beautifulsoup4 python3-jc "
DEPENDS += "bash iproute2 lshw iw iptables sudo util-linux openssl usbutils usbinit pciutils hostapd ethtool "
DEPENDS += "dnsmasq "

RDEPENDS:${PN} += "bash "

S = "${WORKDIR}/git"

FILES:${PN} += "${libdir}/routershell "

do_install() {

    install -d ${D}${libdir}/routershell
    cp -r ${S}/* ${D}${libdir}/routershell

    install -m 0766 ${WORKDIR}/router-shell.sh ${D}${libdir}/routershell/router-shell.sh
}



