#!/bin/bash
choose_a=A. Domoticz + Homebridge
choose_b=B. Ubiquity WiFi controller
choose_c=C. Domoticz only
choose_d=D. Not yet realised


option_a() {
echo ""
echo "Choosed - $choose_a"
echo "Running script..."
echo ""
sudo curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh -o /usr/local/bin/homebridge-install.sh
sudo chmod +x /usr/local/bin/homebridge-install.sh
sudo /usr/local/bin/homebridge-install.sh
exit 1
}
option_b() {
echo ""
echo "Choosed - $choose_b"
echo "Running script..."
echo ""
sudo curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/wificontroller-install.sh -o /usr/local/bin/wificontroller-install.sh
sudo chmod +x /usr/local/bin/wificontroller-install.sh
sudo /usr/local/bin/wificontroller-install.sh
exit 1
}
option_c() {
echo ""
echo "Choosed - $choose_c"
echo "Running script..."
echo ""
sudo curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/domoticz-install.sh -o /usr/local/bin/domoticz-install.sh
sudo chmod +x /usr/local/bin/domoticz-install.sh
sudo /usr/local/bin/domoticz-install.sh
exit 1
}
option_d() {
echo ""
echo "Choosed - $choose_d"
echo "Calling ask_func..."
echo ""
ask_func
}
option_x() {
echo ""
echo "Okay, exiting..."
exit 1
}
option_f() {
echo ""
echo "Dude, choose A, B, C, D or X 🤬"
echo ""
ask_func
}
welcome_func() {
clear
echo ""
echo "Please choose configution:"
echo ""
echo "$choose_a"
echo "$choose_b"
echo "$choose_c"
echo "$choose_d"
echo ""
echo "X. Exit"
echo ""
ask_func
}
ask_func() {
  while true
    do
      read -p "Please enter A, B, C, D or X: " answer
      case $answer in
        [aA]* ) option_a;;
        [bB]* ) option_b;;
        [cC]* ) option_c;;
        [dD]* ) option_d;;
        [xX]* ) option_x;;
        * )     option_f;;
    esac
  done
}
welcome_func
