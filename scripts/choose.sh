#!/bin/sh
echo
echo "Please choose configution:"
echo "a. Domoticz + Homebridge"
echo "b. not yet realised"
echo "c. not yet realised"
echo "x. exit"
read -p "Please choose: a/b/c/x" CONDITION;
if [ "$CONDITION" == "a" ]; then
   echo "Choosed: a. Domoticz + Homebridge"
   # wget "https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh" -O /usr/local/bin/homebridge-install.sh
   # chmod +x /usr/local/bin/homebridge-install.sh
   # /usr/local/bin/homebridge-install.sh
   /usr/local/bin/choose.sh
fi
if [ "$CONDITION" == "b" ]; then
   echo "Choosed: b. not yet realised"
   /usr/local/bin/choose.sh
fi
if [ "$CONDITION" == "c" ]; then
   echo "Choosed: c. not yet realised"
   /usr/local/bin/choose.sh
fi
if [ "$CONDITION" == "x" ]; then
   echo "Choosed: x. exit"
   echo "Rebooting..."
   reboot
fi
