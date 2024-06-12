SUMMARY = "BMROS init.d Startup"
DESCRIPTION = "bare-metal-router factory and start-up settings"
LICENSE = "CLOSED"

SRC_URI = "file://my_script.py \
           file://bmros-init.sh"

FLAG_FILE_DIR = "/var/flags"
FLAG_FILE_NAME = "bmros.FACTORY_START"
FFN = "${FLAG_FILE_DIR}/${FLAG_FILE_NAME}"

FILES:${PN} += "${FFN} "

S = "${WORKDIR}"

do_install() {

    install -m 0600 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FFN}

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/bmros-init.sh ${D}${sysconfdir}/init.d/bmros.sh

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/my_script.py ${D}${libdir}/routershell/scripts/my_script.py

    install -d ${D}${localstatedir}/log
    install -d ${D}${localstatedir}/run
}

INITSCRIPT_NAME = "my_python_script"
INITSCRIPT_PARAMS = "defaults"

inherit update-rc.d
