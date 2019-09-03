#!/bin/bash
option_a() {
echo ""
echo "Choosed - A. Domoticz + Homebridge"
echo "Running script"
echo ""
curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/domoticz-install.sh -o /usr/local/bin/domoticz-install.sh
chmod +x /usr/local/bin/domoticz-install.sh
/usr/local/bin/domoticz-install.sh
exit 1
}
option_b() {
echo ""
echo "Choosed - B. Ubiquity WiFi controller"
echo "Running script"
echo ""
curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/wificontroller-install.sh -o /usr/local/bin/wificontroller-install.sh
chmod +x /usr/local/bin/wificontroller-install.sh
/usr/local/bin/wificontroller-install.sh
exit 1
}
option_c() {
echo ""
echo "Choosed - C. Not yet realised"
echo "Calling ask_func"
echo ""
ask_func
}
option_d() {
echo ""
echo "Choosed - D. Not yet realised"
echo "Calling ask_func"
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
echo "A. Domoticz + Homebridge"
echo "B. Ubiquity WiFi controller"
echo "C. Not yet realised"
echo "D. Not yet realised"
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
