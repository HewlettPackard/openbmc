FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN} = "phosphor-pid-control.service"

SRC_URI += "file://config.json \
            file://0001-Ignore-reading-error-from-sysfs-read.patch \
            file://0002-FIX-Request-external-Hwmon-bus-name-while-external-s.patch \
            "

FILES_${PN} += "usr/*"

do_install() {
  oe_runmake install DESTDIR=${D}

  install -d ${D}/usr/share/swampd/
  install -m 0644 ${WORKDIR}/config.json ${D}/usr/share/swampd/
}

