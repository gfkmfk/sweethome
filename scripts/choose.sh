CHOOSE() {
echo
echo "Please choose configution:"
echo "a. Domoticz + Homebridge"
echo "b. not yet realised"
echo "c. not yet realised"
read -p "a / b / c" RESP
if [ "$RESP" = "a" ]; then
echo "Choosed: a. Domoticz + Homebridge"
# wget "https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh" -O /usr/local/bin/homebridge-install.sh
# chmod +x /usr/local/bin/homebridge-install.sh
# /usr/local/bin/homebridge-install.sh
/usr/local/bin/choose.sh
else
  if [ "$RESP" = "b" ]; then
  echo "b. not yet realised"
  /usr/local/bin/choose.sh
  else
    if [ "$RESP" = "c" ]; then
    echo "c. not yet realised"
    /usr/local/bin/choose.sh
    else
      echo "Incorrect input!
      /usr/local/bin/choose.sh
    fi
  fi
fi
