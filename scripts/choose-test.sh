#!/bin/bash
# Prompt user, and read command line argument
read -p "Run the cron script now? " answer

# Handle the command line argument we were given
case $answer in
   [yY]* ) echo "Okay, you choosed Y"
           break;;

   [nN]* ) echo "Great, you choosed N"
           exit;;

   * )     echo "Dude, just enter Y or N, please."; break ;;
  esac
done
