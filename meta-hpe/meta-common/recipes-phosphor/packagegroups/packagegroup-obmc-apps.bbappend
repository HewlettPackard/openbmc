RDEPENDS_${PN}-logging += "phosphor-logging"
RDEPENDS_${PN}-extras += " bmcweb \
                           phosphor-webui \
                           phosphor-image-signing \
                           phosphor-cooling-type \
                           phosphor-pid-control \
                           ethernet-mac-setting \
                           vehci-gxp-b0-workarround \
                           obmc-asset-patch \
                           host-boot-enable \
                           phosphor-sel-logger \
                           first-boot-set-hostname \
"

RDEPENDS_${PN}-fan-control = " \
         ${VIRTUAL-RUNTIME_obmc-fan-control} \
         "
