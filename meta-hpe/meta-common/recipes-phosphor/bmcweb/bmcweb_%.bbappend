FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

EXTRA_OECMAKE += " -DBMCWEB_HTTP_REQ_BODY_LIMIT_MB=33"

SRC_URI += "file://0001-Tweak-DBus-object-path-for-BIOS-factory-reset.patch"

