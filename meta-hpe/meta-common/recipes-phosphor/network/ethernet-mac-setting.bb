SUMMARY = "Ethernet MAC setting"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

SYSTEMD_SERVICE_${PN} += "ethernet-mac-setting@.service"

MAC_INSTANCES ?= "0 1"


TMPL = "ethernet-mac-setting@.service"
INSTFMT = "ethernet-mac-setting@{0}.service"
MAC_FMT = "../${TMPL}:multi-user.target.wants/${INSTFMT}"
SYSTEMD_LINK_${PN} += "${@compose_list_zip(d, 'MAC_FMT', 'MAC_INSTANCES')}"

SRC_URI += "file://ethernet-mac-setting@.service"
SRC_URI += "file://ethernet-mac-setting.sh"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/ethernet-mac-setting.sh ${D}${bindir}
}
