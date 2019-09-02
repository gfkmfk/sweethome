#!/bin/bash
# Memory split
GPU_MEM=16
# Set Locale
LOCALE=en_US.UTF-8
# Set Timezone
TIMEZONE=Europe/Moscow
# Expand Filesystem
echo "Ensures that all of the SD card storage is available to the OS"
raspi-config nonint do_expand_rootfs
echo "Root partition has been resized"
# Set Boot options
echo "Setting Boot options"
raspi-config nonint do_boot_behaviour B1
raspi-config nonint do_boot_wait 0
echo "Setting Boot options complete"
# Set Advanced options
echo "Setting Advanced options"
raspi-config nonint do_memory_split $GPU_MEM
raspi-config nonint do_resolution 2 82
raspi-config nonint do_overscan 0
echo "Setting Advanced options complete"
# Set Interfacing options
echo "Setting Interfacing options"
raspi-config nonint do_camera 1
raspi-config nonint do_ssh 0
raspi-config nonint do_vnc 1
raspi-config nonint do_spi 1
raspi-config nonint do_i2c 1
raspi-config nonint do_serial 0
raspi-config nonint do_onewire 1
raspi-config nonint do_rgpio 1
echo "Setting Interfacing options complete"
# Set Locale options
echo "Setting Locale options"
raspi-config nonint do_change_locale $LOCALE
raspi-config nonint do_change_timezone $TIMEZONE
echo "Setting Locale options complete" 
{
local AMSURE
if [ -n "Choose" ] ; then
   echo "a. homebridge-install.sh"
   echo "b. not yet realised"
   echo "c. not yet realised"
   read -n 1 -p "Choose (a/b/c): " AMSURE
else
   read -n 1 AMSURE
fi
echo "" 1>&2
if [ "$AMSURE" = "a" ] ; then
   # Call homebridge-install.sh
   wget "https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh" -O /usr/local/bin/homebridge-install.sh
   chmod +x /usr/local/bin/homebridge-install.sh
   /usr/local/bin/homebridge-install.sh
else
   if [ "$AMSURE" = "b" ] ; then
   # Call 
   echo "nope"
   else
      if [ "$AMSURE" = "c" ] ; then
      # Call 
      echo "nope"
      else
         reboot
      fi
   fi
fi
}
