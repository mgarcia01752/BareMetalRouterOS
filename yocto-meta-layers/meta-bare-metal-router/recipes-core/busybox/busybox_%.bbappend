# SUMMARY = "Custom BusyBox Configuration"
# LICENSE = "MIT"
# LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# SRC_URI += "file://custom_busybox_config"

#do_configure:prepend() {
#    cp ${WORKDIR}/custom_busybox_config .config
#}

# inherit busybox

# FILES_${PN} += "/usr/share/busybox/"
