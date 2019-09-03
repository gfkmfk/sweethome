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
  #exit
}
option_3() {
  echo "test opt_3"
  #exit
}
option_4() {
  echo "test opt_4"
  #exit
}
option_X() {
  echo "Okay, exiting"
  exit
}
option_F() {
  echo ""
  echo "Dude, just enter 1, 2, 3, 4 or X 🤬"
  ask_fn
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
  echo "What you choose?: " 
  read ans
  echo ""
  echo "Okay, you choosed "${ans}"..."
  echo ""
  sleep 10
  if   [ "$ans" == "1" ]; then option_1
  elif [ "$ans" == "2" ]; then option_2
  elif [ "$ans" == "3" ]; then option_3
  elif [ "$ans" == "4" ]; then option_4
  elif [ "$ans" == "x" ]; then option_X
  elif [ "$ans" == "X" ]; then option_X
  else option_F
  fi
}
welcome_fn
