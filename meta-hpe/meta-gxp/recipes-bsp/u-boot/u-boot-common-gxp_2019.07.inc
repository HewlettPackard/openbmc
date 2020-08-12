HOMEPAGE = "https://github.hpe.com/hpe-iop/iop-uboot"
DEPENDS += "flex-native bison-native bc-native"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/gpl-2.0.txt;md5=b234ee4d69f5fce4486a80fdaf4a4263"
PE = "1"

# We use the revision in order to avoid having to fetch it from the
# repo during parse
SRCREV = "00a2e4a1663b1bd801fd5a360769b2232ade0035"
UBRANCH = "v2019.07-gxp-openbmc"
SRC_URI = "git://git@github.hpe.com/hpe-iop/iop-uboot.git;branch=${UBRANCH};protocol=ssh"

S = "${WORKDIR}/git"

PV = "v2019.07+git${SRCPV}"
