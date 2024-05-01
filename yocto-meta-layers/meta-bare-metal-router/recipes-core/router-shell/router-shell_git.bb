# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

SRC_URI = "git://github.com/mgarcia01752/RouterShell.git;protocol=https;branch=yocto-bmr"

# Modify these as desired
PV = "1.0+git"
SRCREV = "908c6d330d7ab53b06bcee40f2078166b7fba622"

DEPENDS += "python3 python3-cmd2 \
                    python3-tabulate \
                    python3-prettytable \
                    python3-argcomplete "

# PYPI_PACKAGE = "python3-cmd2"

RDEPENDS:${PN} += "bash"

S = "${WORKDIR}/git"

FILES:${PN} += "${sysconfdir}/routershell"

do_install() {
    # Install configuration files to /etc/routershell
    install -d ${D}${sysconfdir}/routershell
    install -m 0766 ${S}/start.sh ${D}${sysconfdir}/routershell

    install -d ${D}${sysconfdir}/routershell/lib
    cp -r ${S}/config/* ${D}${sysconfdir}/routershell/config

    # Install files from the lib directory
    install -d ${D}${sysconfdir}/routershell/lib
    cp -r ${S}/lib/* ${D}${sysconfdir}/routershell/lib

    # Install files from the cli directory
    install -d ${D}${sysconfdir}/routershell/lib/cli
    cp -r ${S}/lib/cli/* ${D}${sysconfdir}/routershell/lib/cli

    # Install files from the common directory
    install -d ${D}${sysconfdir}/routershell/lib/common
    cp -r ${S}/lib/common/* ${D}${sysconfdir}/routershell/lib/common

    # Install files from the db directory
    install -d ${D}${sysconfdir}/routershell/lib/db
    cp -r ${S}/lib/db/* ${D}${sysconfdir}/routershell/lib/db

    # Install files from the hardware directory
    install -d ${D}${sysconfdir}/routershell/lib/hardware
    cp -r ${S}/lib/hardware/* ${D}${sysconfdir}/routershell/lib/hardware

    # Install files from the network_manager directory
    install -d ${D}${sysconfdir}/routershell/lib/network_manager
    cp -r ${S}/lib/network_manager/* ${D}${sysconfdir}/routershell/lib/network_manager

    # Install files from the network_services directory
    install -d ${D}${sysconfdir}/routershell/lib/network_services
    cp -r ${S}/lib/network_services/* ${D}${sysconfdir}/routershell/lib/network_services

    # Install files from the system directory
    install -d ${D}${sysconfdir}/routershell/lib/system
    cp -r ${S}/lib/system/* ${D}${sysconfdir}/routershell/lib/system

    # Install files from the src directory
    install -d ${D}${sysconfdir}/routershell/src
    cp -r ${S}/src/* ${D}${sysconfdir}/routershell/src
}



