#!/bin/bash

# Set Hostname
HOSTNAME=SweetHomeAutomationUnit

# Setting config and autostart files for Homebridge
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
cat <<EOF > /etc/systemd/system/homebridge.service
[Unit]
Description=SweetHome homebridge server
After=syslog.target network-online.target
[Service]
Type=simple
User=homebridge
ExecStart=/usr/local/bin/homebridge -U /var/homebridge
Restart=on-failure
RestartSec=10
KillMode=process
[Install]
WantedBy=multi-user.target
EOF
  
# Setting install stage (1)
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
# Updating software and Installing prerequisites
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
sleep 5
sudo apt-get install -y git make g++ nodejs libavahi-compat-libdnssd-dev npm
sleep 5
# Removing previous stage (1) and setting next stage (2)
systemctl disable homebridge-install1.service
systemctl daemon-reload
systemctl enable homebridge-install2.service
sleep 10
reboot
EOF
  
# Setting install stage (2)
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
# Installing Homebridge, platforms, set user and check again for updates
npm install -g homebridge
npm install -g homebridge-edomoticz
sleep 5
useradd --system homebridge
mkdir /home/homebridge
chown -Rf homebridge /home/homebridge
sleep 5
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
sleep 10
# Removing previous stage (2) and setting next stage (3)
systemctl disable homebridge-install2.service
systemctl daemon-reload
systemctl enable homebridge-install3.service
sleep 10
reboot
EOF

#Setting install stage (3)  
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
# Installing Domoticz and Setting up Homebridge
curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/domoticz-install.sh -o /usr/local/bin/domoticz-install.sh
chmod +x /usr/local/bin/domoticz-install.sh
/usr/local/bin/domoticz-install.sh
sleep 10
systemctl daemon-reload
sleep 20
systemctl enable homebridge
# Removing previous stage (3) and cleaning up
systemctl disable homebridge-install3.service
systemctl daemon-reload
rm -rf /usr/local/bin/homebridge-install.sh
rm -rf /usr/local/bin/domoticz-install.sh
rm -rf /usr/local/bin/choose.sh
rm -rf /usr/local/bin/main-install.service
rm -rf /etc/systemd/system/homebridge-install1.service
rm -rf /usr/local/bin/homebridge-install1.sh
rm -rf /etc/systemd/system/homebridge-install2.service
rm -rf /usr/local/bin/homebridge-install2.sh
rm -rf /etc/systemd/system/homebridge-install3.service
rm -rf /usr/local/bin/homebridge-install3.sh
systemctl daemon-reload
sleep 10
reboot
EOF

# Set permissions for config and autorun files
chmod -R 0777 /var/homebridge
chmod 664 /etc/systemd/system/homebridge.service
chmod 664 /etc/systemd/system/homebridge-install1.service
chmod 744 /usr/local/bin/homebridge-install1.sh
chmod 664 /etc/systemd/system/homebridge-install2.service
chmod 744 /usr/local/bin/homebridge-install2.sh
chmod 664 /etc/systemd/system/homebridge-install3.service
chmod 744 /usr/local/bin/homebridge-install3.sh
  
# Enable autorun for 1st stage
systemctl daemon-reload
systemctl enable homebridge-install1.service

# Set Hostname
raspi-config nonint do_hostname $HOSTNAME
sleep 5

reboot
exit
