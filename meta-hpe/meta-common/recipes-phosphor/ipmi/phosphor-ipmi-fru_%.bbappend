FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append = " obmc-yaml-config"

EXTRA_OECONF = " \
    YAML_GEN=${STAGING_DIR_HOST}${datadir}/obmc-yaml-config/fru-read.yaml \
    PROP_YAML=${STAGING_DIR_HOST}${datadir}/obmc-yaml-config/extra-properties.yaml \
   "

SRC_URI += "file://0001-Fix-incorrect-FRU-offset-length.patch \
            file://0002-Fix-ipmitool-edit-fru-failed.patch \
            "

