SUMMARY = "Recipe to create Asset property in inventory manager"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${HPEBASE}/COPYING.apache-2.0;md5=34400b68072d710fecd0a2940a0d1658"

inherit allarch
inherit phosphor-inventory-manager

PROVIDES += "virtual/phosphor-inventory-manager-asset"
S = "${WORKDIR}"

SRC_URI += "file://asset.yaml"

do_install() {
        install -D asset.yaml ${D}${base_datadir}/events.d/asset.yaml
}

FILES_${PN} += "${base_datadir}/events.d/asset.yaml"
