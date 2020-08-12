SUMMARY = "OBMC YAML configuration"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

SRC_URI = " \
    file://obmc-fru-read.yaml \
    file://obmc-extra-properties.yaml \
    file://obmc-sensor.yaml \
    file://obmc-inventory-sensor.yaml \
    "

S = "${WORKDIR}"

do_install() {
    install -m 0644 -D obmc-extra-properties.yaml \
        ${D}${datadir}/${BPN}/extra-properties.yaml
    install -m 0644 -D obmc-fru-read.yaml \
        ${D}${datadir}/${BPN}/fru-read.yaml
    install -m 0644 -D obmc-sensor.yaml \
        ${D}${datadir}/${BPN}/sensor.yaml
    install -m 0644 -D obmc-inventory-sensor.yaml \
        ${D}${datadir}/${BPN}/inventory-sensor.yaml
}

FILES_${PN}-dev = " \
    ${datadir}/${BPN}/extra-properties.yaml \
    ${datadir}/${BPN}/fru-read.yaml \
    ${datadir}/${BPN}/sensor.yaml \
    ${datadir}/${BPN}/inventory-sensor.yaml \
    "

ALLOW_EMPTY_${PN} = "1"
