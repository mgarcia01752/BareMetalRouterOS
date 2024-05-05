
SUMMARY = "Converts the output of popular command-line tools and file-types to JSON."
HOMEPAGE = "https://github.com/kellyjonbrazil/jc"
AUTHOR = "Kelly Brazil <kellyjonbrazil@gmail.com>"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=e1e4c3f1ac5aa48ee23021d045410b6e"

SRC_URI = "https://files.pythonhosted.org/packages/39/2e/c0d557b2ee673e2e0aef24a01e732aa232f6b1e180f339058f674f391ab8/jc-1.25.2.tar.gz"
SRC_URI[md5sum] = "e042a82acf978e5dc16dd1ac9371e97a"
SRC_URI[sha256sum] = "97ada193495f79550f06fe0cbfb119ff470bcca57c1cc593a5cdb0008720e0b3"

S = "${WORKDIR}/jc-1.25.2"

RDEPENDS:${PN} = "python3-ruamel-yaml python3-xmltodict python3-pygments"

inherit setuptools3
