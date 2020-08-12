#!/bin/sh

function yww_fetch_year() {
  case `hexdump -s 4 -n 1 /sys/bus/i2c/devices/2-0050/eeprom -v -e '"%c"'` in
    6) echo 2016;;
    7) echo 2017;;
    8) echo 2018;;
    9) echo 2019;;
    0) echo 2020;;
    1) echo 2021;;
    2) echo 2022;;
    3) echo 2023;;
    4) echo 2024;;
    5) echo 2025;;
    *) echo 2016;;
  esac
}

function yww_fetch_week() {
  ww_hi=`hexdump -s 5 -n 1 /sys/bus/i2c/devices/2-0050/eeprom -v -e '"%c"'`
  ww_lo=`hexdump -s 6 -n 1 /sys/bus/i2c/devices/2-0050/eeprom -v -e '"%c"'`
  ww=$((ww_hi))$((ww_lo))
  if [ $ww -ge 1 ] && [ $ww -le 53 ]; then echo $ww; else echo 1; fi
}

function yww_convert() {
#  ordinal(date)=week(date)* 7+weekday(date)-(weekday(year(date),1,4)+3)
#  if ordinal<1 then ordinal=ordinal+daysInYear(year-1)
#  if ordinal>daysInYear(year) then ordinal=ordinal-daysInYear(year)
  year=$1
  week=$2
  weekday=1 #Monday
  buildtime=`date -d"8:0:0" +%T`

  weekdayyear=`date -d "$year-01-04" +%w`
  ordinal=$((10#$week * 7 + 10#$weekday - 10#$weekdayyear - 3))
  daysinyear=`date -d"$year-12-31" +%j`
  if [ $ordinal -lt 1 ]; then
    year=$((10#$year - 1))
    daysinyear=`date -d"$year-12-31" +%j`
    ordinal=$((10#$ordinal + 10#$daysinyear))
  elif [ $ordinal -gt $daysinyear ]; then
    ordinal=$((10#$ordinal - 10#$daysinyear))
    year=$((10#$year + 1))
  fi
  pre_dayofweek=1
  for month in `seq 2 12`
  do
    dayofweek=`date -d"$year-$month-01" +%j`
    if [ $ordinal -lt $dayofweek ]; then
      month=$((10#$month - 1))
      day=$((10#$ordinal - 10#$pre_dayofweek + 1))
      break
    else
      pre_dayofweek=$dayofweek
      if [ $month -eq 12 ]; then
        day=$((10#$ordinal - 10#$pre_dayofweek + 1))
      fi
    fi
  done
  echo "$year-$month-$day - $buildtime"
}

id=$(( (("$(devmem 0xd1000302 8)" << 8) | "$(devmem 0xd1000301 8)") & 0xfff ))
case $id in
  $((0x204))) model="DL360 Gen10";;
  $((0x205))) model="DL380 Gen10";;
  $((0x225))) model="DL360 Gen10 Plus";;
  $((0x226))) model="DL380 Gen10 Plus";;
  *) model="DL380 Gen10";;
esac
echo "model: set to $model"
busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Item PrettyName s "$model"
busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard xyz.openbmc_project.Inventory.Item PrettyName s "$model"

year_code=`yww_fetch_year`
week_code=`yww_fetch_week`
mfgdate=`yww_convert $year_code $week_code`
if [ "m${mfgdate}" != "m" ]; then
  echo "mfgdate:set to $mfgdate"
  busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard xyz.openbmc_project.Inventory.Decorator.Asset BuildDate s "$mfgdate"
else
  echo "mfgdate: null value in eeprom, keep default"
fi

serial_pca=`hexdump -s 144 -n 16 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/16 "%s"'`
if [ "s${serial_pca}" != "s" ]; then
  echo "pca serial:set to $serial_pca"
  busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard xyz.openbmc_project.Inventory.Decorator.Asset SerialNumber s "$serial_pca"
else
  echo "pca serial: null value in eeprom, keep default"
fi

serial_sys=`hexdump -s 1 -n 16 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/16 "%s"'`
if [ "s${serial_sys}" != "s" ]; then
  echo "sys serial:set to $serial_sys"
  busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset SerialNumber s "$serial_sys"
else
  echo "sys serial: null value in eeprom, keep default"
fi

# "089455-001"
partnumber_pca=`hexdump -s 160 -n 16 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/16 "%s"'`
if [ "p${partnumber_pca}" != "p" ]; then
  echo "pca part number: set to $partnumber_pca"
  busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system/chassis/motherboard xyz.openbmc_project.Inventory.Decorator.Asset PartNumber s "$partnumber_pca"
else
  echo "pca part number: null value in eeprom, keep default"
fi

partnumber_sys=`hexdump -s 109 -n 16 /sys/bus/i2c/devices/2-0050/eeprom -v -e '1/16 "%s"'`
if [ "p${partnumber_sys}" != "p" ]; then
  echo "sys part number: set to $partnumber_sys"
  busctl set-property xyz.openbmc_project.Inventory.Manager /xyz/openbmc_project/inventory/system xyz.openbmc_project.Inventory.Decorator.Asset Model s "$partnumber_sys"
else
  echo "sys part number: null value in eeprom, keep default"
fi
