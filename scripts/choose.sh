#!/bin/bash
while true
do
  # (1) prompt user, and read command line argument
  read -p "Run the cron script now? " answer

  # (2) handle the input we were given
  case $answer in
   [aA]* ) echo "Okay, just ran the cron script.a"
           break;;
           
   [bB]* ) echo "Okay, just ran the cron script.b"
           break;;
           
   [cC]* ) echo "Okay, just ran the cron script.c"
           break;;

   [xX]* ) exit;;

   * )     echo "Dude, just enter A, B, C or X, please.";;
  esac
done
