FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-DEV-Support-power-operation.patch;striplevel=2"
SRC_URI += "file://0002-Implement-press_power_button-function.patch;striplevel=2"
