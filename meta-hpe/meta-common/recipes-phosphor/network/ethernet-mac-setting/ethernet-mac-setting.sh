#!/bin/sh


if [ "$1" == "0" ]; then
  mac=`hexdump -s 132 -n 6 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/1 "%02x:"' | cut -c 0-17`
elif [ "$1" == "1" ]; then
  echo 2 > /sys/class/soc/xreg/sideband_sel
  mac=`hexdump -s 138 -n 6 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/1 "%02x:"' | cut -c 0-17`
fi

if [ `echo $mac | egrep "^([a-fA-F0-9]{2}:){5}[a-fA-F0-9]{2}$"` ]
then
        echo "eth$1:set mac addr to $mac"
        ifconfig eth$1 down
        ifconfig eth$1 hw ether $mac
        busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/bmc_eth$1 xyz.openbmc_project.Inventory.Item.NetworkInterface MACAddress s "$mac"
else
        echo "eth$1:invalid mac addr"
fi

