#!/bin/bash

which sonarr > /tmp/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

  ALREADYINSTALLED

else

  EXPLAINTASK
  
  CONFIRMATION

  if [[ ${REPLY} =~ ^[Yy]$ ]]; then

    GOAHEAD

    # ----------
    # Open ports
    # ----------

    sudo ufw allow 8989

    # ------------
    # Dependencies
    # ------------

    sudo apt-get upgrade -y && sudo apt-get upgrade -y

    sudo -s apt-get -y install \
      libcurl3 \
      libmono-cil-dev \
      mono-devel \
      mediainfo \
      sqlite3 \
      denyhosts at sudo software-properties-common

    # -----------
    # Main script
    # -----------

    # Execution

    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
    sudo echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list

    sudo apt-get -y update
    clear
    sudo apt-get -y install nzbdrone

    sudo chown -R plexuser:plexuser /opt/NzbDrone

    sudo rsync -a /opt/GooPlex/scripts/sonarr.service /etc/systemd/system/sonarr.service
    sudo systemctl enable sonarr.service
    sudo systemctl daemon-reload
    sudo systemctl start sonarr.service
	
    TASKCOMPLETE

  else

    CANCELTHIS

  fi

fi

rm /tmp/checkapp.txt
PAUSE
