SUMMARY = "Append base-files"
DESCRIPTION = "Customizing base-files for bare-metal-router setting"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://bmr-start-motd"

do_install:append() {
    rm -f ${D}${sysconfdir}/motd
    install -m 0600 ${UNPACKDIR}/bmr-start-motd ${D}${sysconfdir}/motd
}

FILES:${PN} += "${sysconfdir}/motd"

hostname = "Router"
