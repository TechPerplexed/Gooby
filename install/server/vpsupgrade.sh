#!/bin/bash

clear

# Explanation

echo -e "--------------------------------------------------"
echo -e " ${RED}DANGER ZONE!!!${STD}"
echo -e " This will upgrade your server to the latest version"
echo -e " ${YELLOW}CAUTION!!!${STD} Make SURE you have a backup!"
echo -e "--------------------------------------------------"
echo ""

# Confirmation

read -p "Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # Upgrade

  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt autoremove -y
  sudo apt autoclean
  sudo apt-get autoremove
  sudo apt install update-manager-core -y
  sudo do-release-upgrade

  # Task Completed

  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " ${PERFORM} $TASK completed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"

else

  echo ""
  echo -e "--------------------------------------------------"
  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${TASK}"
  echo -e "--------------------------------------------------"
  echo ""

fi

PAUSE
