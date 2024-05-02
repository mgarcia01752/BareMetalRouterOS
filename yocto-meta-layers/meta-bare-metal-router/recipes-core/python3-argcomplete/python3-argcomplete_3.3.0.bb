
SUMMARY = "Bash tab completion for argparse"
HOMEPAGE = "https://github.com/kislyuk/argcomplete"
AUTHOR = "Andrey Kislyuk <kislyuk@gmail.com>"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.rst;md5=2ee41112a44fe7014dce33e26468ba93"

SRC_URI = "https://files.pythonhosted.org/packages/79/51/fd6e293a64ab6f8ce1243cf3273ded7c51cbc33ef552dce3582b6a15d587/argcomplete-3.3.0.tar.gz"
SRC_URI[md5sum] = "255e2c9f2cdb18f88d1dc8de9b78a072"
SRC_URI[sha256sum] = "fd03ff4a5b9e6580569d34b273f741e85cd9e072f3feeeee3eba4891c70eda62"

S = "${WORKDIR}/argcomplete-3.3.0"

RDEPENDS_${PN} = ""

inherit setuptools3
