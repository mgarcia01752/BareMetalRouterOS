SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Debug Flag"
LICENSE = "CLOSED"

FLAG_FILE_DIR = "/var/flags"
FLAG_FILE_NAME = "bmros.DEBUG"
FFN_DEBUG = "${FLAG_FILE_DIR}/${FLAG_FILE_NAME}"

FILES:${PN} += "${FFN_DEBUG} "

do_install() {
    install -m 0600 -d ${D}${FLAG_FILE_DIR}
    touch ${D}${FFN_DEBUG}
}
