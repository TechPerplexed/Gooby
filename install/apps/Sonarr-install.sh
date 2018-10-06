#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  if [ ! -d "/opt/NzbDrone" ];   then

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

  else

    clear
    echo -e "Sonarr is already installed!"
    echo -e "You can update it from within the application itself."
 
  fi

  if [ ! -e "/etc/systemd/system/sonarr.service" ]; then

    sudo rsync -a /opt/GooPlex/scripts/sonarr.service /etc/systemd/system/sonarr.service
    sudo systemctl enable sonarr.service
    sudo systemctl daemon-reload
    sudo systemctl start sonarr.service

  fi

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
