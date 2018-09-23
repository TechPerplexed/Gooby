#!/bin/bash

FUNCTION="upgrade server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# Explanation

echo -e "-----------------------------------------------------"
echo -e " This will upgrade your server to the latest version "
echo -e "       ${yellow}CAUTION!!!${STD} Make SURE you have a backup!       "
echo -e "-----------------------------------------------------"
echo ""

# Confirmation

read -p "Are you ${red}REALLY${STD} sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

  # -----------
  # Main script
  # -----------

  # Initial update

  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt autoremove -y
  sudo apt autoclean
  sudo apt-get autoremove
  sudo apt install update-manager-core -y
  sudo do-release-upgrade

else

  echo ""
  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
