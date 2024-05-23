SUMMARY = "Start Program at Boot"
DESCRIPTION = "A systemd service unit to start a program at bootup"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "router-shell"

START_SERVICE="start-routershell.service"
START_SHELL="start-routershell.sh"

SRC_URI += "file://${START_SHELL} \
            file://${START_SERVICE}"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/${START_SERVICE} ${D}${systemd_unitdir}/system
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/${START_SHELL} ${D}${bindir}
}

FILES:${PN} += "${systemd_unitdir}/system/${START_SERVICE} \
                ${bindir}/${START_SHELL}"

SYSTEMD_SERVICE:${PN} = "${START_SERVICE}"
