SUMMARY = "BMROS Factory Start-Up"
DESCRIPTION = "bare-metal-router factory start-up settings"
LICENSE = "CLOSED"

SRC_URI = "file://my_script.py \
           file://my_python_script"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/my_script.py ${D}${bindir}/my_script.py

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/my_python_script ${D}${sysconfdir}/init.d/my_python_script

    install -d ${D}${localstatedir}/log
    install -d ${D}${localstatedir}/run
}

INITSCRIPT_NAME = "my_python_script"
INITSCRIPT_PARAMS = "defaults"

inherit update-rc.d
