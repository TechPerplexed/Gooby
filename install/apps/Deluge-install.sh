#!/bin/bash

clear

# Explanation

echo -e "--------------------------------------------------"
echo -e " This will ${PERFORM} $TASK}"
echo -e " You probably only need to run this once..."
echo -e "--------------------------------------------------"
echo ""

# Confirmation

read -p " Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # ----------
  # Open ports
  # ----------

  sudo ufw allow 8112

  # ------------
  # Dependencies
  # ------------

  sudo apt-get upgrade -y && sudo apt-get upgrade -y

  # -----------
  # Main script
  # -----------

  # Execution

  sudo apt-get -y install \
    deluged \
    deluge-webui \
    deluge-console \
    denyhosts at sudo software-properties-common

  # -------------------
  # Installing Services
  # -------------------

  sudo rsync -a /opt/GooPlex/scripts/deluged.service /etc/systemd/system/deluged.service
  sudo rsync -a /opt/GooPlex/scripts/deluge-web.service /etc/systemd/system/deluge-web.service

  sudo systemctl enable deluged.service
  sudo systemctl enable deluge-web.service

  sudo systemctl daemon-reload

  sudo systemctl start deluged.service
  sudo systemctl start deluge-web.service

  # ----------------
  # Creating Folders
  # ----------------

  sudo mkdir -p /home/plexuser/downloads/incomplete
  sudo mkdir -p /home/plexuser/downloads/import
  sudo chown -R plexuser:plexuser /home/plexuser
  
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
