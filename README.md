# SweetHome


Running main script:

sudo curl -L https://github.com/gfkmfk/sweethome/raw/master/scripts/main-install.sh -o /usr/local/bin/main-install.sh && sudo chmod +x /usr/local/bin/main-install.sh $$ sudo /usr/local/bin/main-install.sh


-> Choose A

  Hostaname: SweetHomeAutomationUnit
  
  Domoticz install location: /var/domoticz
  
  HTTP port: 80
  
  HTTPS port: 443
  
  Edit Homebridge config: nano /var/homebridge/config.json
  
  Check Homebridge status: journalctl -f -u homebridge
  
  Web: https://SweetHomeAutomationUnit



-> Choose B

  Hostname: SweetHomeWiFiController
  
  Web: https://SweetHomeWiFiController:8443
