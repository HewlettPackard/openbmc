SUMMARY = "OBMC asset info patch"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

SYSTEMD_SERVICE_${PN} += "obmc-asset-patch.service"

TMPL = "obmc-asset-patch.service"
LINK_INST = "../${TMPL}:multi-user.target.wants/${TMPL}"
SYSTEMD_LINK_${PN} += "${LINK_INST}"

SRC_URI += "file://obmc-asset-patch.service"
SRC_URI += "file://obmc-asset-patch.sh"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/obmc-asset-patch.sh ${D}${bindir}
}
