#!/bin/bash

FUNCTION="install or update Radarr"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear
read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

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

# Execution

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian jessie main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list

cd /tmp
clear
echo "Copy Linux version from https://github.com/Radarr/Radarr/releases/"
read -e -p "Paste link to Radarr.verson.linux.tar.gz: " -i "https://github.com/Radarr/Radarr/releases/download/v0.2.0.995/Radarr.develop.0.2.0.995.linux.tar.gz" radarr
wget $radarr

sudo tar -xf Radarr* -C /opt/
sudo chown -R plexuser:plexuser /opt/Radarr

# -------------------
# Installing Services
# -------------------

if [ -e "/etc/systemd/system/radarr.service" ]

then

echo "Service already configured, skipping"

else

sudo rsync -a /opt/GooPlex/scripts/services/radarr.service /etc/systemd/system/radarr.service
sudo systemctl enable radarr.service
sudo systemctl daemon-reload
sudo systemctl start radarr.service

fi

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
