
SUMMARY = "Makes working with XML feel like you are working with JSON"
HOMEPAGE = "https://github.com/martinblech/xmltodict"
AUTHOR = "Martin Blech <martinblech@gmail.com>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=01441d50dc74476db58a41ac10cb9fa2"

SRC_URI = "https://files.pythonhosted.org/packages/39/0d/40df5be1e684bbaecdb9d1e0e40d5d482465de6b00cbb92b84ee5d243c7f/xmltodict-0.13.0.tar.gz"
SRC_URI[md5sum] = "1ece0a5bbd494bac414058405606475e"
SRC_URI[sha256sum] = "341595a488e3e01a85a9d8911d8912fd922ede5fecc4dce437eb4b6c8d037e56"

S = "${WORKDIR}/xmltodict-0.13.0"

RDEPENDS_${PN} = ""

inherit setuptools3
