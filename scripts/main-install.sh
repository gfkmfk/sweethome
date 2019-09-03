#!/bin/bash
# Memory split
GPU_MEM=16
# Set Locale
LOCALE=en_US.UTF-8
# Set Timezone
TIMEZONE=Europe/Moscow
# Expand Filesystem
raspi-config nonint do_expand_rootfs
# Set Boot options
raspi-config nonint do_boot_behaviour B1
raspi-config nonint do_boot_wait 0
# Set Advanced options
raspi-config nonint do_memory_split $GPU_MEM
raspi-config nonint do_resolution 2 82
raspi-config nonint do_overscan 0
# Set Interfacing options
raspi-config nonint do_camera 1
raspi-config nonint do_ssh 0
raspi-config nonint do_vnc 1
raspi-config nonint do_spi 1
raspi-config nonint do_i2c 1
raspi-config nonint do_serial 0
raspi-config nonint do_onewire 1
raspi-config nonint do_rgpio 1
# Set Locale options
raspi-config nonint do_change_locale $LOCALE
raspi-config nonint do_change_timezone $TIMEZONE
# Call Choose
curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/choose.sh -o /usr/local/bin/choose.sh
chmod +x /usr/local/bin/choose.sh
/usr/local/bin/choose.sh
exit
