FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_append = " obmc-yaml-config"

EXTRA_OECONF= " \
    SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/obmc-yaml-config/sensor.yaml \
    INVSENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/obmc-yaml-config/inventory-sensor.yaml \
    FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/obmc-yaml-config/fru-read.yaml \
    HOST_MANAGER_PATH=/xyz/openbmc_project/Ipmi/Channel/ipmi_kcs1 \
    HOST_MANAGER_INTF=xyz.openbmc_project.Ipmi.Channel.SMS \
    IPMI_HOST_SHUTDOWN_COMPLETE_TIMEOUT_SECS=60 \
    "

SRC_URI += "file://0001-Configurable-MACRO-in-BB-recipe.patch \
            file://0002-DEV-Set-PWM-Fan-Unit-to-Percentage.patch \
            file://0003-Support-power-button-to-do-a-soft-power-off.patch \
            "

SYSTEMD_SERVICE_${PN} += " xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service"

do_replace_entity_default() {

    # The in-repo provided default is tailored to testing the ipmid code.
    # Replace it with a reasonable default for users.
    cp ${THISDIR}/${PN}/entity.yaml ${S}/scripts/entity-example.yaml
}
