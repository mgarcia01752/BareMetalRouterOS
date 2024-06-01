SUMMARY = "Append base-files"
DESCRIPTION = "Customizing base-files for bare-metal-router setting"
LICENSE = "MIT"

SRC_URI = "file://motd"

# Overwrite hostname
hostname = "Router"

do_install:append(){
    install -m 0644 ${WORKDIR}/motd ${D}${sysconfdir}/motd
}

