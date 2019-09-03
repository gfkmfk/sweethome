#!/bin/bash
echo
echo "Please choose configution:"
echo
echo "A. Domoticz + Homebridge"
echo "B. Ubiquity WiFi controller"
echo "C. Not yet realised"
echo "D. Not yet realised"
echo
echo "X. Exit"
echo
echo "-"
while true
do
  # (1) prompt user, and read command line argument
  read -p "Please enter A, B, C, D or X: " answer

  # (2) handle the input we were given
  case $answer in
   [aA]* ) echo 
           echo "Choosed: A. Domoticz + Homebridge"
           echo
           echo "Running sript"
           echo
           exec curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh | sudo bash
           break;;
           
   [bB]* ) echo 
           echo "Choosed: B. Ubiquity WiFi controller"
           echo
           echo "Running sript"
           echo
           exec curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/wificontroller-install.sh | sudo bash
           break;;
           
   [cC]* ) echo
           echo "Choosed: C. Not yet realised"
           echo;;
           
   [dD]* ) echo
           echo "Choosed: D. Not yet realised"
           echo;;

   [xX]* ) echo
           echo "Exiting"
           echo
           exit;;

   * )     echo
           echo "Dude, just enter A, B, C, D or X, please."
           echo;;
  esac
done
