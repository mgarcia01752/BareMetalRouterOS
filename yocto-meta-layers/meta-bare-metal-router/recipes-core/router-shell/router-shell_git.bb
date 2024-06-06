SUMMARY = "RouterShell"
DESCRIPTION = "RouterShell is an open-source IOS-like CLI distribution in Python 3"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

PV = "0.1.5+git${SRCPV}"
SRCREV = "4e6566933f8d187d9828ca28190de527db956846"

SRC_URI = "git://github.com/mgarcia01752/RouterShell.git;protocol=https;branch=v0.1.5;rev=${SRCREV} "
SRC_URI += "file://router-shell.sh"

DEPENDS += "python3 python3-pygments python3-prompt-toolkit python3-tabulate python3-prettytable python3-beautifulsoup4 python3-jc "
DEPENDS += "iproute2 lshw iw bash iptables net-tools sudo util-linux openssl usbutils usbinit pciutils hostapd ethtool bridge-utils "
DEPENDS += "dnsmasq "

RDEPENDS:${PN} += "bash "

S = "${WORKDIR}/git"

FILES:${PN} += "${libdir}/routershell "

do_install() {

    install -d ${D}${libdir}/routershell
    cp -r ${S}/* ${D}${libdir}/routershell

    install -m 0766 ${WORKDIR}/router-shell.sh ${D}${libdir}/routershell/router-shell.sh
    install -m 0766 ${S}/start.sh ${D}${libdir}/routershell/start.sh

}



