SUMMARY = "Init BMC Hostname"
DESCRIPTION = "Setup BMC Unique hostname"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit obmc-phosphor-systemd

SYSTEMD_SERVICE_${PN} = "first-boot-set-hostname.service"

SRC_URI = "file://${BPN}.sh file://${BPN}.service" 

S = "${WORKDIR}"
do_install() {
    sed "s/{MACHINE}/${MACHINE}/" -i ${PN}.sh
    install -d ${D}${bindir} ${D}${systemd_system_unitdir}
    install ${PN}.sh ${D}${bindir}/
    install -m 644 ${PN}.service ${D}${systemd_system_unitdir}/
}
