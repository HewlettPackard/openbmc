SUMMARY = "SNMP Configuration"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit native
inherit phosphor-dbus-monitor

SRC_URI += "file://example.yaml"

do_install() {
        install -D ${WORKDIR}/example.yaml ${D}${config_dir}/example.yaml
}
