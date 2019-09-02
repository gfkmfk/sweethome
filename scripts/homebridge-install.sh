#!/bin/bash
# Set Hostname
HOSTNAME=SweetHomeAutomationUnit
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
# Set Hostname
echo "Setting Hostname"
raspi-config nonint do_hostname $HOSTNAME
echo "Hostname has been changed"
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
# Setting autostart files
cat <<EOF > /etc/default/homebridge
# Defaults / Configuration options for homebridge
# The following settings tells homebridge where to find the config.json file and where to persist the data (i.e. pairing and others)
HOMEBRIDGE_OPTS=-U /var/homebridge

# If you uncomment the following line, homebridge will log more
# You can display this via systemd’s journalctl: journalctl -f -u homebridge
# DEBUG=*
EOF
cat <<EOF > /etc/systemd/system/homebridge.service
[Unit]
Description=SweetHome homebridge server
After=syslog.target network-online.target

[Service]
Type=simple
User=homebridge
EnvironmentFile=/etc/default/homebridge
ExecStart=/usr/local/bin/homebridge $HOMEBRIDGE_OPTS
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
mkdir /var/homebridge
cat <<EOF > /var/homebridge/config.json
{
  "bridge": {
    "name": "SweetHome",
    "username": "B8:27:EB:74:43:65",
    "port": 51826,
    "pin": "815-59-703"
  },

  "description": "This is testing configuration file for SweetHome.",
  "ports": {
    "start": 52100,
    "end": 52150,
    "comment": "This section is used to control the range of ports that separate accessory."
  },
  "accessories": [
  ],

  "platforms": [
     {
        "platform": "eDomoticz",
            "name": "SweetHome",
            "server": "admin:< pass look at notes :) >@127.0.0.1",
            "port": "443",
            "ssl": 1,
            "roomid": 0,
            "mqtt": 1
     }
  ]
}
EOF
chmod -R 0777 /var/homebridge
chmod 664 /etc/systemd/system/homebridge.service
chmod 664 /etc/default/homebridge
chmod 664 /etc/systemd/system/homebridge-install1.service
chmod 744 /usr/local/bin/homebridge-install1.sh
chmod 664 /etc/systemd/system/homebridge-install2.service
chmod 744 /usr/local/bin/homebridge-install2.sh
chmod 664 /etc/systemd/system/homebridge-install3.service
chmod 744 /usr/local/bin/homebridge-install3.sh
systemctl daemon-reload
# Setting stage (1)
cat <<EOF > /etc/systemd/system/homebridge-install1.service
[Unit]
After=homebridge-install1.service
[Service]
ExecStart=/usr/local/bin/homebridge-install1.sh
[Install]
WantedBy=default.target
EOF
cat <<EOF > /usr/local/bin/homebridge-install1.sh
#!/bin/bash
sleep 30
# Updating software
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
# Installing prerequisites
sudo apt-get install -y git make g++ nodejs libavahi-compat-libdnssd-dev npm
# Removing previous stage (1) and setting next stage (2)
systemctl disable homebridge-install1.service
systemctl daemon-reload
systemctl enable homebridge-install2.service
sleep 20
reboot
EOF
# Setting stage (2)
cat <<EOF > /etc/systemd/system/homebridge-install2.service
[Unit]
After=homebridge-install2.service
[Service]
ExecStart=/usr/local/bin/homebridge-install2.sh
[Install]
WantedBy=default.target
EOF
cat <<EOF > /usr/local/bin/homebridge-install2.sh
#!/bin/bash
sleep 30
# Installing Homebridge and platforms
npm install -g homebridge
npm install -g homebridge-edomoticz
useradd --system homebridge
# Removing previous stage (2) and setting next stage (3)
systemctl disable homebridge-install2.service
systemctl daemon-reload
systemctl enable homebridge-install3.service
sleep 20
reboot
EOF
#Setting stage (3)
cat <<EOF > /etc/systemd/system/homebridge-install3.service
[Unit]
After=homebridge-install3.service
[Service]
ExecStart=/usr/local/bin/homebridge-install3.sh
[Install]
WantedBy=default.target
EOF
cat <<EOF > /usr/local/bin/homebridge-install3.sh
#!/bin/bash
sleep 30
# Setting up Homebridge and platforms
systemctl enable homebridge
# Removing previous stage (3) and cleaning up
systemctl disable homebridge-install3.service
systemctl daemon-reload
rm -rf /usr/local/bin/homebridge-install.sh
rm -rf /etc/systemd/system/homebridge-install1.service
rm -rf /usr/local/bin/homebridge-install1.sh
rm -rf /etc/systemd/system/homebridge-install2.service
rm -rf /usr/local/bin/homebridge-install2.sh
rm -rf /etc/systemd/system/homebridge-install3.service
rm -rf /usr/local/bin/homebridge-install3.sh
systemctl daemon-reload
sleep 5
reboot
EOF
systemctl daemon-reload
systemctl enable homebridge-install1.service
reboot
