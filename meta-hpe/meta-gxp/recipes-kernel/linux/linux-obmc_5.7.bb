KBRANCH ?= "dev-5.7-gxp-openbmc"
LINUX_VERSION ?= "5.7.10"

SRCREV="3662c3a27d7a3ad0201e7a5e57fedf03c5bd18b3"
require linux-obmc.inc
require conf/machine/include/fitimage-sign.inc

SRC_URI += "file://phosphor-gpio-keys.scc"
SRC_URI += "file://phosphor-gpio-keys.cfg"
