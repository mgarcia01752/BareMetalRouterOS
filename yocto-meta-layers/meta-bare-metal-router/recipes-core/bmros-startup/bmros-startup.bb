SUMMARY = "BMROS init.d Startup"
DESCRIPTION = "bare-metal-router factory and start-up settings"
LICENSE = "CLOSED"

SRC_URI = "file://bmros-init.sh \
           file://router-shell.sh \
           file://startup-config.cfg"

FLAG_FILE_DIR = "/var/flags"
FACTORY_START_FILE_NAME = "bmros.FACTORY_START"
FSFN = "${FLAG_FILE_DIR}/${FACTORY_START_FILE_NAME}"

S = "${WORKDIR}"

INITSCRIPT_NAME = "bmros.sh"
INITSCRIPT_PARAMS = "defaults"

inherit update-rc.d

FILES:${PN} += "${sysconfdir}/init.d/${INITSCRIPT_NAME} ${FSFN} \
                ${libdir}/routershell/router-shell.sh \
                ${libdir}/routershell/config/startup-config.cfg \
                ${libdir}/routershell \
                ${libdir}/routershell/config"

do_install() {

    # Set Initial Start Flags (MUST BE 0600)
    install -m 0600 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FSFN}

    # Install SysV init.d files
    install -d ${D}${sysconfdir}/init.d
    install -m 0754 ${WORKDIR}/bmros-init.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    # Install BMROS specific RouterShell start/install/configuration files
    install -d ${D}${libdir}/routershell
    install -m 0754 ${WORKDIR}/router-shell.sh ${D}${libdir}/routershell/router-shell.sh
    
    install -d ${D}${libdir}/routershell/config
    install -m 0654 ${WORKDIR}/startup-config.cfg ${D}${libdir}/routershell/config/startup-config.cfg 

}

