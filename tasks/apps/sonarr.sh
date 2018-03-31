#!/bin/bash

FUNCTION="install or update Sonarr"

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

sudo ufw allow 8989

# ------------
# Dependencies
# ------------

sudo apt-get upgrade -y && sudo apt-get upgrade -y

sudo apt-get -y install \
  libcurl3 \
  libmono-cil-dev \
  mono-devel \
  mediainfo \
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

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
