FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
PACKAGECONFIG_append  = " associations"
SRC_URI_append = " file://associations.json"

SRC_URI += "file://0001-Remove-association-interface-when-destroy-object.patch"

DEPENDS += " \
        phosphor-inventory-manager-asset \
        inventory-cleanup \
        "

do_install_append() {
    install -d ${D}${base_datadir}
    install -m 0755 ${WORKDIR}/associations.json ${D}${base_datadir}/associations.json

}
