SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Production Flag"
LICENSE = "CLOSED"

FLAG_FILE_DIR = "/var/flags"
FLAG_FILE_NAME = "routershell.PRODUCTION"
FFN = "${FLAG_FILE_DIR}/${FLAG_FILE_NAME}"

FILES:${PN} += "${FFN} "

do_install() {
    install -m 0600 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FFN}
}
