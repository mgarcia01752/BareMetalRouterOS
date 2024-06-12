SUMMARY = "BMROS init.d Startup"
DESCRIPTION = "bare-metal-router factory and start-up settings"
LICENSE = "CLOSED"

SRC_URI = "file://bmros-init.sh "
SRC_URI += "file://router-shell.sh "
SRC_URI += "file://startup-config.cfg "

FLAG_FILE_DIR = "/var/flags"
FACTORY_START_FILE_NAME = "bmros.FACTORY_START"
FSFN = "${FLAG_FILE_DIR}/${FACTORY_START_FILE_NAME}"

FILES:${PN} += "${FSFN} "

S = "${WORKDIR}"

INITSCRIPT_NAME = "bmros.sh"
INITSCRIPT_PARAMS = "defaults"

do_install() {

    # Set Initial Start Flags
    install -m 0660 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FSFN}

    # Install SysV init.d files
    install -d ${D}${sysconfdir}/init.d
    install -m 0754 ${WORKDIR}/bmros-init.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    # Install BMROS specific RouterShell start/install/configuration files
    install -d ${D}${libdir}/routershell
    install -m 0754 ${WORKDIR}/router-shell.sh ${D}${libdir}/routershell/router-shell.sh
    install -m 0654 ${WORKDIR}/startup-config.cfg  ${D}${libdir}/routershell/config/startup-config.cfg 

    # BMOS Logging Directories
    install -d ${D}${localstatedir}/log
    install -d ${D}${localstatedir}/run
}

inherit update-rc.d
