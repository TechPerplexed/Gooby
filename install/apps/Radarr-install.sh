#!/bin/bash

which radarr > /tmp/checkapp.txt
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

    sudo ufw allow 7878

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

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    echo "deb http://download.mono-project.com/repo/debian jessie main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

    cd /tmp
    clear
    echo -e "Copy latest Linux version from ${YELLOW}https://github.com/Radarr/Radarr/releases/${STD}"
    echo -e "Remove link below and paste link to Radarr.verson.linux.tar.gz"
    echo -e "Or you can press Enter to install ${CYAN}v0.2.0.995${STD}:"
    echo ""
    read -e -p "Link: " -i "https://github.com/Radarr/Radarr/releases/download/v0.2.0.1120/Radarr.develop.0.2.0.1120.linux.tar.gz" radarr
    wget $radarr

    sudo tar -xf Radarr* -C /opt/
    sudo chown -R plexuser:plexuser /opt/Radarr
  
    # -------------------
    # Installing Services
    # -------------------

    sudo rsync -a /opt/GooPlex/scripts/radarr.service /etc/systemd/system/radarr.service
    sudo systemctl enable radarr.service
    sudo systemctl daemon-reload
    sudo systemctl start radarr.service
	
	TASKCOMPLETE

  else

    CANCELTHIS

  fi

fi

rm /tmp/checkapp.txt
PAUSE
