FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
inherit systemd

SYSTEMD_SERVICE_${PN} = "rngd.service"

SRC_URI += "file://rngd.service \
"

