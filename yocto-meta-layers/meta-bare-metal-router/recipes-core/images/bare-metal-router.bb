SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Production Image"
LICENSE = "MIT"

require recipes-core/images/bare-metal-router-vanilla.bb
require recipes-core/login-check/login-check.bb

RDEPENDS:${PN} += "router-shell-flags-prod "

IMAGE_INSTALL:append = "router-shell-flags-prod "