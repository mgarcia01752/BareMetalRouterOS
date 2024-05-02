
SUMMARY = "Pretty-print tabular data"
HOMEPAGE = ""
AUTHOR = " <Sergey Astanin <s.astanin@gmail.com>>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=6ad1430c0c4824ec6a5dbb9754b011d7"

SRC_URI = "https://files.pythonhosted.org/packages/ec/fe/802052aecb21e3797b8f7902564ab6ea0d60ff8ca23952079064155d1ae1/tabulate-0.9.0.tar.gz"
SRC_URI[md5sum] = "3b10bb64f8a06ca7549d3481b7e6c028"
SRC_URI[sha256sum] = "0095b12bf5966de529c0feb1fa08671671b3368eec77d7ef7ab114be2c068b3c"

S = "${WORKDIR}/tabulate-0.9.0"

RDEPENDS_${PN} = ""

inherit setuptools3
