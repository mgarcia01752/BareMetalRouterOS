SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Debug Image"
LICENSE = "MIT"

require recipes-core/images/bare-metal-router-vanilla.bb

RDEPENDS:${PN} += "router-shell-flags-debug "

IMAGE_INSTALL:append = "router-shell-flags-debug "

IMAGE_INSTALL:append = "tree "