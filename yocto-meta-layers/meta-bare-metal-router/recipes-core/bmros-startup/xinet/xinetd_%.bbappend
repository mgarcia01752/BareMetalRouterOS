SUMMARY = "Telnet Server"
DESCRIPTION = "Disable telnet server upon bootup"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THIS_DIR}/files:"

SRC_URI += "file://xinet-telnet-disabled"

do_install:append() {
    install -d ${D}${sysconfdir}/xinetd.d
    install -m 0644 ${WORKDIR}/xinet-telnet-disabled ${D}${sysconfdir}/xinetd.d/telnet
}

INITSCRIPT_NAME = "xinetd"
INITSCRIPT_PARAMS = "defaults"
