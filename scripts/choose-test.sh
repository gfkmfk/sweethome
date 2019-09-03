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
  echo "What you choose?: " 
  read ans
  echo "You typed "${ans}""
  sleep 10
  if   [ "$ans" == "1" ]; then
    clear
    echo ""
    echo "Okay, you choosed ${choose_1}..."
    echo ""
    sleep 3
    option_1
  elif [ "$ans" == "2" ]; then
    clear        
    echo ""
    echo "Okay, you choosed ${choose_2}..."
    echo ""
    sleep 3
    option_2
  elif [ "$ans" == "3" ]; then
    clear
    echo ""
    echo "Okay, you choosed ${choose_3}..."
    echo ""
    sleep 3
    option_3
  elif [ "$ans" == "4" ]; then
    clear
    echo ""
    echo "Okay, you choosed ${choose_4}..."
    echo ""
    sleep 3
    option_4
  elif [ "$ans" == "x" ]; then
    echo ""
    echo "Okay, exiting..."
    echo ""
    sleep 3
    clear
    exit
  elif [ "$ans" == "X" ]; then
    echo ""
    echo "Okay, exiting..."
    echo ""
    sleep 3
    clear
    exit
  else
    echo ""
    echo "Dude, just enter 1, 2, 3, 4 or X 🤬"
    ask_fn
  fi
}
welcome_fn
