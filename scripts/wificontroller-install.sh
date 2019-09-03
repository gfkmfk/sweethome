#!/bin/bash
# Set Hostname
HOSTNAME=SweetHomeWiFiController
# Setting stage (1)
cat <<EOF > /etc/systemd/system/wificontroller-install1.service
[Unit]
After=wificontroller-install1.service
[Service]
ExecStart=/usr/local/bin/wificontroller-install1.sh
[Install]
WantedBy=default.target
EOF
cat <<EOF > /usr/local/bin/wificontroller-install1.sh
#!/bin/bash
sleep 30
# Updating sources
apt-get update
# Installing prerequisites
echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list
sudo wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ubnt.com/unifi/unifi-repo.gpg
apt-get update
apt-get upgrade -y
apt-get install openjdk-8-jre-headless haveged -y
# Updating software
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
# Removing previous stage (1) and setting next stage (2)
systemctl disable wificontroller-install1.service
systemctl daemon-reload
systemctl enable wificontroller-install2.service
sleep 20
reboot
EOF
# Setting stage (2)
cat <<EOF > /etc/systemd/system/wificontroller-install2.service
[Unit]
After=wificontroller-install2.service
[Service]
ExecStart=/usr/local/bin/wificontroller-install2.sh
[Install]
WantedBy=default.target
EOF
cat <<EOF > /usr/local/bin/wificontroller-install2.sh
#!/bin/bash
sleep 30
# Installing software
apt-get update
apt-get install unifi -y
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y
# Removing previous stage (2) and cleaning up
systemctl stop mongodb 
systemctl disable mongodb
systemctl disable wificontroller-install2.service
systemctl daemon-reload
rm -rf /usr/local/bin/wificontroller-install.service
rm -rf /usr/local/bin/main-install.sh
rm -rf /usr/local/bin/choose.ch
rm -rf /etc/systemd/system/wificontroller-install1.service
rm -rf /usr/local/bin/wificontroller-install1.sh
rm -rf /etc/systemd/system/wificontroller-install2.service
rm -rf /usr/local/bin/wificontroller-install2.sh
systemctl daemon-reload
sleep 20
reboot
EOF
chmod 664 /etc/systemd/system/wificontroller-install1.service
chmod 744 /usr/local/bin/wificontroller-install1.sh
chmod 664 /etc/systemd/system/wificontroller-install2.service
chmod 744 /usr/local/bin/wificontroller-install2.sh
systemctl daemon-reload
systemctl enable wificontroller-install1.service
sleep 5
# Set Hostname
raspi-config nonint do_hostname $HOSTNAME
sleep 5
reboot
exit
