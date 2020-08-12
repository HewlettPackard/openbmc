#!/bin/sh -eu

show_error() {
    echo "$@" >&2
}

sync_hostname() {
    MAPPER_IFACE='xyz.openbmc_project.ObjectMapper'
    MAPPER_PATH='/xyz/openbmc_project/object_mapper'
    INVENTORY_PATH='/xyz/openbmc_project/inventory'
    BMC_ITEM_IFACE='xyz.openbmc_project.Inventory.Item.Bmc'

    BMC_ITEM_PATH=$(busctl --no-pager --verbose call \
                            ${MAPPER_IFACE} \
                            ${MAPPER_PATH} \
                            ${MAPPER_IFACE} \
                            GetSubTree sias \
                            ${INVENTORY_PATH} 0 1 ${BMC_ITEM_IFACE} \
                        2>/dev/null | grep ${INVENTORY_PATH} || true)

    BMC_ITEM_PATH=${BMC_ITEM_PATH#*\"}
    BMC_ITEM_PATH=${BMC_ITEM_PATH%\"*}

    BMC_ITEM_SERVICE=$(mapper get-service \
                                ${BMC_ITEM_PATH} 2>/dev/null || true)

    if [[ -z "${BMC_ITEM_SERVICE}" ]]; then
        show_error "No BMC item found in the Inventory. Is VPD EEPROM empty?" >&2
	BMC_SN=""
    else
        BMC_SN=$(busctl get-property ${BMC_ITEM_SERVICE} \
                                ${BMC_ITEM_PATH} \
                                ${BMC_ITEM_IFACE} SerialNumber)
        BMC_SN=${BMC_SN#*\"}
        BMC_SN=${BMC_SN%\"*}
    fi

    if [[ -z "${BMC_SN}" ]] ; then
        show_error "BMC Serial Number empty! Setting Hostname as 'hostname + mac address' "

        NETWORK_ITEM_IFACE='xyz.openbmc_project.Inventory.Item.NetworkInterface'
        NETWORK_ITEM_PATH=$(busctl --no-pager --verbose call \
                           ${MAPPER_IFACE} \
                           ${MAPPER_PATH} \
                           ${MAPPER_IFACE} \
                           GetSubTree sias \
                                ${INVENTORY_PATH} 0 1 ${NETWORK_ITEM_IFACE} \
                    2>/dev/null | grep ${INVENTORY_PATH} |grep eth0 || true)

        NETWORK_ITEM_PATH=${NETWORK_ITEM_PATH#*\"}
        NETWORK_ITEM_PATH=${NETWORK_ITEM_PATH%\"*}

        NETWORK_ITEM_OBJ=$(mapper get-service ${NETWORK_ITEM_PATH} 2>/dev/null || true)

        if [[ -z "${NETWORK_ITEM_OBJ}" ]]; then
            show_error 'No Ethernet interface found in the Inventory. Unique hostname not set!'
            exit 1
        fi

        MAC_ADDR=$(busctl get-property ${NETWORK_ITEM_OBJ} \
                               ${NETWORK_ITEM_PATH} \
                               ${NETWORK_ITEM_IFACE} MACAddress)

        MAC_ADDR=${MAC_ADDR#*\"}
        MAC_ADDR=${MAC_ADDR%\"*}

        hostnamectl set-hostname $(hostname)-${MAC_ADDR}
    else
        hostnamectl set-hostname $(hostname)-${BMC_SN}
    fi
}

[ "$(hostname)" = "{MACHINE}" ] && sync_hostname

systemctl disable first-boot-set-hostname.service
