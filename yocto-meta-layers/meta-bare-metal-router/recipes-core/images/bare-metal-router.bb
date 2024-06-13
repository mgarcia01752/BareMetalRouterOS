SUMMARY = "Bare Metal RouterOS"
DESCRIPTION = "Bare Metal RouterOS Production Image"
LICENSE = "MIT"

require recipes-core/images/bare-metal-router-vanilla.bb
require recipes-core/bmros-startup/login-check.bb

RDEPENDS:${PN} += " router-shell-flags-prod \
                    router-shell-flags-debug "

IMAGE_INSTALL:append = "router-shell-flags-prod \
                        router-shell-flags-debug "