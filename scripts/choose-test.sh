#!/bin/bash

# Choose options
choose_1="1. Homebridge + Domoticz"
choose_2="2. UniFi Controller"
choose_3="3. -= nope =-"
choose_4="4. -= nope =-"

# Option's functions
option_1() {
echo "test opt_1"
}
option_2() {
echo "test opt_2"
}
option_3() {
echo "test opt_3"
}
option_4() {
echo "test opt_4"
}

# Welcome function
welcome_sessage() {
  echo 
  echo "     Hello and Welcome!"
  echo 
  echo "Choose one of the following"
  echo "configuration  to  install:"
  echo 
  echo "${choose_1}"
  echo "${choose_2}"
  echo "${choose_3}"
  echo "${choose_4}"
  echo 
  ask_script
}

# Ask function
ask_script() {
while true
do
read -p "What you choose?: " answer
case $answer in
   [1]* ) echo "Okay, you choosed ${choose_1}"
          sleep 3
          choose_1
           break;;

   [2]* ) echo "Okay, you choosed ${choose_2}"
          sleep 3
          choose_2
           break;;

   [3]* ) echo "Okay, you choosed ${choose_3}"
          sleep 3
          choose_3
           break;;

   [4]* ) echo "Okay, you choosed ${choose_4}"
          sleep 3
          choose_4
           break;;

   * )     echo "Dude, just enter 1, 2, 3 or 4, please.";;
  esac
done
}
welcome_sessage
