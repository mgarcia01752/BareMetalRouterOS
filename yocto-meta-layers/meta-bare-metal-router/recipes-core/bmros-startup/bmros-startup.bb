SUMMARY = "BMROS init.d Startup"
DESCRIPTION = "bare-metal-router factory and start-up settings"
LICENSE = "CLOSED"

inherit update-rc.d

SRC_URI = "file://bmros-init.sh \
           file://router-shell.sh \
           file://startup-config.cfg \
           file://factory-startup.cfg"

# Define flag file path and name
FLAG_FILE_DIR = "/var/flags"
FACTORY_START_FILE_NAME = "bmros.FACTORY_START"
FSFN = "${FLAG_FILE_DIR}/${FACTORY_START_FILE_NAME}"

# Define init script parameters
INITSCRIPT_NAME = "bmros.sh"
INITSCRIPT_PARAMS = "defaults 99"

# Set the working directory
S = "${WORKDIR}"

# Define files to be included in the package
FILES:${PN} += "${sysconfdir}/init.d/${INITSCRIPT_NAME} \
                ${FSFN} \
                ${libdir}/routershell/router-shell.sh \
                ${libdir}/routershell/config/startup-config.cfg \
                ${libdir}/routershell/config/factory-startup.cfg"

# Install function
do_install() {
    # Ensure the flag directory exists and create the flag file with appropriate permissions
    install -d ${D}${FLAG_FILE_DIR}
    install -m 0600 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FSFN}
    
    # Install SysV init.d files
    install -d ${D}${sysconfdir}/init.d
    install -m 0754 ${WORKDIR}/bmros-init.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    # Install BMROS specific RouterShell start/install/configuration files
    install -d ${D}${libdir}/routershell
    install -m 0754 ${WORKDIR}/router-shell.sh ${D}${libdir}/routershell/router-shell.sh
    
    # Install RouterShell Default Start and Factory Reset Configurations
    install -d ${D}${libdir}/routershell/config
    install -m 0644 ${WORKDIR}/startup-config.cfg ${D}${libdir}/routershell/config/startup-config.cfg
    install -m 0644 ${WORKDIR}/factory-startup.cfg ${D}${libdir}/routershell/config/factory-startup.cfg
}

# Declare dependencies
DEPENDS += "bmros-profile"
