SUMMARY = "BusyBox Overwrite default defconfig"
DESCRIPTION = "This recipe overrides the default BusyBox configuration with a custom defconfig file."
HOMEPAGE = "http://www.busybox.net"
SECTION = "console/utils"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://.config"

do_configure:append() {
    cat ${WORKDIR}/.config >> ${B}/.config
}
