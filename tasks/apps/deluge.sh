#!/bin/bash

FUNCTION="install or update Deluge"

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

sudo ufw allow 8112

# ------------
# Dependencies
# ------------

sudo apt-get upgrade -y && sudo apt-get upgrade -y

sudo apt-get -y install \
  sqlite3 \
  denyhosts at sudo software-properties-common


# None

# -----------
# Main script
# -----------

# Execution

sudo apt-get -y install \
  deluged \
  deluge-webui \
  deluge-console \
  denyhosts at sudo software-properties-common


sudo rsync -a /opt/GooPlex/scripts/etc/systemd/system/rclone.service /etc/systemd/system/deluged.service
sudo rsync -a /opt/GooPlex/scripts/etc/systemd/system/rclone.service /etc/systemd/system/deluge-web.service

sudo systemctl enable deluged.service
sudo systemctl enable deluge-web.service

sudo systemctl daemon-reload

sudo systemctl starr deluged.service
sudo systemctl start deluge-web.service

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
