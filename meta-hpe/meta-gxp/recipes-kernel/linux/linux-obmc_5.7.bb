KBRANCH ?= "dev-5.7"
LINUX_VERSION ?= "5.7.10"

SRCREV="6932278914115849e52b82ff7f1db6adc3767e72"
require linux-obmc.inc
require conf/machine/include/fitimage-sign.inc

SRC_URI += "file://phosphor-gpio-keys.scc"
SRC_URI += "file://phosphor-gpio-keys.cfg"
