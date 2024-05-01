
SUMMARY = "Pygments is a syntax highlighting package written in Python."
HOMEPAGE = ""
AUTHOR = " <Georg Brandl <georg@python.org>>"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=36a13c90514e2899f1eba7f41c3ee592"

SRC_URI = "https://files.pythonhosted.org/packages/55/59/8bccf4157baf25e4aa5a0bb7fa3ba8600907de105ebc22b0c78cfbf6f565/pygments-2.17.2.tar.gz"
SRC_URI[md5sum] = "7c059773b0f4808f9402eb0650de6bd4"
SRC_URI[sha256sum] = "da46cec9fd2de5be3a8a784f434e4c4ab670b4ff54d605c4c2717e9d49c4c367"

S = "${WORKDIR}/pygments-2.17.2"

RDEPENDS_${PN} = ""

inherit setuptools3
