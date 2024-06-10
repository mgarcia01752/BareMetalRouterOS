SUMMARY = "Kernel Overwrite default defconfig"
DESCRIPTION = "This recipe overrides the default Kernel configuration with a custom defconfig file."
HOMEPAGE = "https://www.kernel.org"
SECTION = "kernel"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += "file://.config"

do_configure:append() {
    cat ${WORKDIR}/.config >> ${B}/.config
}
