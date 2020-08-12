FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG[host_bios_upgrade] = "-Dhost-bios-upgrade=enabled"
PACKAGECONFIG_append = " host_bios_upgrade"

SRC_URI += "file://0001-Support-GXP-image.patch \
            file://0002-Support-BIOS-update-function.patch \
            file://0003-add-obmc-flash-bios-script.patch \
            file://0004-get-system-rom-mtd-dev-by-name.patch \
            file://0005-Suport-BIOS-factory-reset.patch"

SYSTEMD_SERVICE_${PN}-updater += " obmc-flash-host-bios@.service"
SYSTEMD_SERVICE_${PN}-updater += " xyz.openbmc_project.Software.BMC.Updater.service"

FILES_${PN}-updater += " ${bindir}/obmc-flash-bios"
