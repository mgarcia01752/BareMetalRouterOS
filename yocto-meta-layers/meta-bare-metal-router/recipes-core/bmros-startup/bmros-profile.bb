SUMMARY = "BMROS Profile"
DESCRIPTION = "Recipe to set global environment variables"
LICENSE = "CLOSED"

# Optionally, set the destination for your configuration file
CONFIG_DEST = "${sysconfdir}/profile.d"

# Specify the files to be installed
SRC_URI += "file://bmros-profile.sh"

# Where to install the files
S = "${WORKDIR}"

do_install() {
    install -d ${D}${CONFIG_DEST}
    install -m 0644 ${WORKDIR}/bmros-profile.sh ${D}${CONFIG_DEST}
}

FILES:${PN} += "${CONFIG_DEST}/*"

inherit allarch

