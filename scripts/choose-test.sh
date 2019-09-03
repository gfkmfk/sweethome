#!/bin/bash

choose_1="1. Homebridge + Domoticz"
choose_2="2. UniFi Controller"
choose_3="3. -= nope =-"
choose_4="4. -= nope =-"

option_1() {
  echo "test opt_1"
  #exit 1
}
option_2() {
  echo "test opt_2"
  #exit 1
}
option_3() {
  echo "test opt_3"
  #exit 1
}
option_4() {
  echo "test opt_4"
  #exit 1
}
option_X() {
  echo "Okay, exiting"
  exit 1
}
option_F() {
  echo ""
  echo "Dude, just enter 1, 2, 3, 4 or X 🤬"
  ask_fn
}

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

ask_fn() {
  echo "What you choose?: " 
  read ans
  echo ""
  echo "Okay, you choosed "${ans}"..."
  echo ""
  sleep 10
  while read -r -n 1 -s answer; do
  if [[ $answer = [1234Xx] ]]; then
    [[ $answer = [1] ]] && option_1
    [[ $answer = [2] ]] && option_2
    [[ $answer = [3] ]] && option_3
    [[ $answer = [4] ]] && option_4
    [[ $answer = [Xx] ]] && option_X
    break 
    else option_F
  fi
done
}
welcome_fn
