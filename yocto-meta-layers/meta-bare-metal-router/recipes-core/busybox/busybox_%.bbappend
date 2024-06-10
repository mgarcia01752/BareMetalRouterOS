SUMMARY = "BusyBox Overwrite default defconfig"
DESCRIPTION = "This recipe overrides the default BusyBox configuration with a custom defconfig file."
HOMEPAGE = "http://www.busybox.net"
SECTION = "console/utils"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://fragment.cfg"

do_configure:append() {
    cat ${WORKDIR}/fragment.cfg >> ${B}/.config
}
