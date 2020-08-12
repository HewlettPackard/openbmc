FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

EXTRA_OECONF_append_dl360poc = " --enable-negative-errno-on-fail"

NAMES = " \
        i2c@c0002500/emc1402@4c \
        i2c@c0002500/emc1404@1c \
        i2c@c0002700/psu@58 \
        i2c@c0002700/psu@59 \
        coretemp@c0000130 \
        fanctrl@c1000c00 \
        syspower \
        "

ITEMSFMT = "ahb@80000000/{0}.conf"

ITEMS = "${@compose_list(d, 'ITEMSFMT', 'NAMES')}"

ENVS = "obmc/hwmon/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN} += "${@compose_list(d, 'ENVS', 'ITEMS')}"
