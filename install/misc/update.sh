#!/bin/bash

clear

# Explanation

echo -e "--------------------------------------------------"
echo -e " This will update GooPlex to the latest version"
echo -e " You can run this as often as you like!"
echo -e "--------------------------------------------------"
echo ""

# Confirmation

read -p " Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # -----------
  # Main script
  # -----------

  cd ~
  sudo rm -r /opt/GooPlex
  sudo git clone https://github.com/TechPerplexed/GooPlex /opt/GooPlex
  sudo chmod +x -R /opt/GooPlex/install
  sudo chmod +x -R /opt/GooPlex/menus
  sudo rsync -a /opt/GooPlex/install/gooplex /bin
  sudo chmod 755 /bin/gooplex

  clear

  # Task Completed

  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " ${PERFORM} $TASK completed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"

else

  echo ""
  echo -e "--------------------------------------------------"
  echo -e " You chose ${YELLOW}not${STD} to ${PERFORM} ${TASK}"
  echo -e "--------------------------------------------------"
  echo ""

fi

PAUSE
