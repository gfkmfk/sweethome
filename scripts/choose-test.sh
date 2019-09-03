#!/bin/bash

# Choose options
choose_1="1. Homebridge + Domoticz"
choose_2="2. UniFi Controller"
choose_3="3. -= nope =-"
choose_4="4. -= nope =-"

# Option's functions
option_1() {
echo "test opt_1"
#exit
}
option_2() {
echo "test opt_2"
exit
}
option_3() {
echo "test opt_3"
#exit
}
option_4() {
echo "test opt_4"
#exit
}

# Welcome function
welcome_fn() {
  clear
  echo ""
  echo "     Hello and Welcome!"
  echo ""
  echo "Choose one of the following"
  echo "configuration  to  install:"
  echo ""
  echo "${choose_1}"
  echo "${choose_2}"
  echo "${choose_3}"
  echo "${choose_4}"
  echo ""
  echo "X. Exit script"
  ask_fn
}

# Ask function
ask_fn() {
read -t 10 -p "What you choose?: " answer
case $answer in
  [1]* )  clear
          echo ""
          echo "Okay, you choosed ${choose_1}"
          echo ""
          sleep 3
          choose_1
          break;;

  [2]* )  clear
          echo ""
          echo "Okay, you choosed ${choose_2}..."
          echo ""
          sleep 3
          choose_2
          break;;

  [3]* )  clear
          echo ""
          echo "Okay, you choosed ${choose_3}..."
          echo ""
          sleep 3
          choose_3
          break;;

  [4]* )  clear
          echo ""
          echo "Okay, you choosed ${choose_4}..."
          echo ""
          sleep 3
          choose_4
          break;;

  [xX]* ) echo ""
          echo "Okay, exiting..."
          echo ""
          sleep 3
          clear
          exit;;

  * )     echo ""
          echo "Dude, just enter 1, 2, 3, 4 or X 🤬"
          ask_script;;
esac
}
welcome_fn
