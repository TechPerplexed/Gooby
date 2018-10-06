#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # ----------
  # Open ports
  # ----------

  sudo ufw allow 19999

  # ------------
  # Dependencies
  # ------------

  sudo apt-get upgrade -y && sudo apt-get upgrade -y
  sudo -s apt-get -y install \
    unzip \
    curl \
    denyhosts at sudo software-properties-common

  # -----------
  # Main script
  # -----------

  # Execution

  clear
  bash <(curl -Ss https://my-netdata.io/kickstart.sh)

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
