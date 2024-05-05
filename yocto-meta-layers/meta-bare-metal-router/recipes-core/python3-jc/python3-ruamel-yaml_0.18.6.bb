
SUMMARY = "ruamel.yaml is a YAML parser/emitter that supports roundtrip preservation of comments, seq/map flow style, and map key order"
HOMEPAGE = ""
AUTHOR = "Anthon van der Neut <a.van.der.neut@ruamel.eu>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=30cbbccd94bf3a2b0285ec35671a1938"

SRC_URI = "https://files.pythonhosted.org/packages/29/81/4dfc17eb6ebb1aac314a3eb863c1325b907863a1b8b1382cdffcb6ac0ed9/ruamel.yaml-0.18.6.tar.gz"
SRC_URI[md5sum] = "964a8e48646e26533d8e5f03cff99dde"
SRC_URI[sha256sum] = "8b27e6a217e786c6fbe5634d8f3f11bc63e0f80f6a5890f28863d9c45aac311b"

S = "${WORKDIR}/ruamel.yaml-0.18.6"

RDEPENDS:${PN} = ""

inherit setuptools3
