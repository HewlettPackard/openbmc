SUMMARY = "VEHCI GXP B0 Workarround"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

DEPENDS += "virtual/obmc-gpio-monitor"
RDEPENDS_${PN} += "virtual/obmc-gpio-monitor"

SYSTEMD_ENVIRONMENT_FILE_${PN} += "obmc/gpio/port_owner_udc0"
SYSTEMD_ENVIRONMENT_FILE_${PN} += "obmc/gpio/port_owner_udc1"

UDC0_GPIO = "port_owner_udc0"
UDC1_GPIO = "port_owner_udc1"
TMPL_GPIO = "phosphor-gpio-monitor@.service"
INSTFMT_GPIO = "phosphor-gpio-monitor@{0}.service"
TGT_GPIO = "multi-user.target.requires"
FMT_GPIO = "../${TMPL_GPIO}:${TGT_GPIO}/${INSTFMT_GPIO}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT_GPIO', 'UDC0_GPIO')}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT_GPIO', 'UDC1_GPIO')}"

UDC0_VEHCI = "udc0"
UDC1_VEHCI = "udc1"
TMPL_VEHCI = "vehci-gxp-b0-workarround@.service"
INSTFMT_VEHCI = "vehci-gxp-b0-workarround@{0}.service"
FMT_VEHCI = "${TMPL_VEHCI}:${INSTFMT_VEHCI}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT_VEHCI', 'UDC0_VEHCI')}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'FMT_VEHCI', 'UDC1_VEHCI')}"

SYSTEMD_SERVICE_${PN} += "vehci-gxp-b0-workarround@.service"

SRC_URI += "file://udc-reconnect.sh"
SRC_URI += "file://vehci-gxp-b0-workarround@.service"

do_install() {
	install -d ${D}${bindir}
	install -m 755 ${WORKDIR}/udc-reconnect.sh ${D}${bindir}
}
