#!/bin/bash
echo
echo
echo "Please choose configution:"
echo
echo "A. Domoticz + Homebridge"
echo "B. Not yet realised"
echo "C. Not yet realised"
echo
echo "X. Exit"
echo
while true
do
  # (1) prompt user, and read command line argument
  read -p "Please enter A, B, C or X: " answer

  # (2) handle the input we were given
  case $answer in
   [aA]* ) echo "Choosed: A. Domoticz + Homebridge"
           # wget "https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh" -O /usr/local/bin/homebridge-install.sh
           # chmod +x /usr/local/bin/homebridge-install.sh
           # /usr/local/bin/homebridge-install.sh
           /usr/local/bin/choose.sh
           break;;
           
   [bB]* ) echo "Choosed: B. Not yet realised"
           /usr/local/bin/choose.sh
           break;;
           
   [cC]* ) echo "Choosed: C. Not yet realised"
           /usr/local/bin/choose.sh
           break;;

   [xX]* ) "Exiting"
           exit;;

   * )     echo "Dude, just enter A, B, C or X, please.";;
  esac
done
