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
  ask_script
}

# Ask function
ask_script() {
read -p "What you choose?: " answer
case $answer in
   [1]* ) clear
          echo ""
          echo "Okay, you choosed ${choose_1}"
          echo ""
          sleep 3
          choose_1
           break;;

   [2]* ) clear
          echo ""
          echo "Okay, you choosed ${choose_2}..."
          echo ""
          sleep 3
          choose_2
           break;;

   [3]* ) clear
          echo ""
          echo "Okay, you choosed ${choose_3}..."
          echo ""
          sleep 3
          choose_3
           break;;

   [4]* ) clear
          echo ""
          echo "Okay, you choosed ${choose_4}..."
          echo ""
          sleep 3
          choose_4
           break;;

   [xX]* ) clear
           echo ""
           echo "Okay, exiting..."
           echo ""
           sleep 3
            exit;;

   * )     echo ""
           echo "Dude, just enter 1, 2, 3, 4 or X please.";;
           echo ""
           ask_script
             break;;
  esac
done
}
welcome_sessage

