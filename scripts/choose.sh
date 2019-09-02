CHOOSE() {
echo
echo "Please choose configution:"
echo "a. Domoticz + Homebridge"
echo "b. not yet realised"
echo "c. not yet realised"
select yn in "a" "b" "c"; do
    case $yn in
        a ) wget "https://github.com/gfkmfk/sweethome/raw/master/scripts/homebridge-install.sh" -O /usr/local/bin/homebridge-install.sh; chmod +x /usr/local/bin/homebridge-install.sh; /usr/local/bin/homebridge-install.sh;;
        b ) echo "nope"; CHOOSE;;
        c ) echo "nope"; CHOOSE;;
    esac
done
}
CHOOSE
