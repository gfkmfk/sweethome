while true
do
  # (1) prompt user, and read command line argument
  read -p "Run the cron script now? " answer

  # (2) handle the input we were given
  case $answer in
   [yY]* ) /usr/bin/wget -O - -q -t 1 http://www.example.com/cron.php
           echo "Okay, just ran the cron script."
           break;;

   [nN]* ) exit;;

   * )     echo "Dude, just enter Y or N, please.";;
  esac
done
