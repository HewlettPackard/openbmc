FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://nm-sensors.json \
            file://0001-Add-CPU-and-DIMM-temperature-sensors-using-NM-comman.patch \
            file://0002-Add-present-and-functional-status-of-CPU-and-DIMM-to.patch \
            file://0003-Check-sensor-threshold-while-sensor-presented.patch"
#            file://0004-Change-return-value-to-ENXIO-if-unavailable.patch

FILES_${PN} += "/usr/share/dbussensors/nm-sensors.json"

SYSTEMD_SERVICE_${PN} = "xyz.openbmc_project.ipmbsensor.service"
EXTRA_OECMAKE += "-DDISABLE_ADC=1 \
                  -DDISABLE_CPU=1 \
                  -DDISABLE_EXIT_AIR=1 \
                  -DDISABLE_FAN=1 \
                  -DDISABLE_HWMON_TEMP=1 \
                  -DDISABLE_INTRUSION=1 \
                  -DDISABLE_MCUTEMP=1 \
                  -DDISABLE_PSU=1 \
                  "

do_install_append(){
    install -m 0644 -D ${WORKDIR}/nm-sensors.json ${D}/usr/share/dbussensors/nm-sensors.json
}
