SUMMARY = "Custom U-Boot Configuration"
DESCRIPTION = "This bbappend customizes the U-Boot configuration for the Bare Metal Router OS."
LICENSE="CLOSED"
SECTION = "u-boot"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://.config"

do_configure:append() {
    cp ${WORKDIR}/.config ${S}/configs/
}
