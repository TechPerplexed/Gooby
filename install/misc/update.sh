#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
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

  # -----------
  # Explanation
  # -----------

  echo -e "${LMAGENTA}"
  echo -e "------------------------------------------------"
  echo -e " GooPlex has been updated to the latest version "
  echo -e "------------------------------------------------"
  echo -e "${STD}"

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
