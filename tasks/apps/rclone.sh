#!/bin/bash

FUNCTION="install or update Rclone"

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

# -----------
# Main script
# -----------

# Explanation

clear
echo -e "This will " $FUNCTION
echo ""

# Execution

cd /tmp

read -e -p "Release (R) or Beta installation (B)? " -i "R" choice

case "$choice" in 
  b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
  * ) curl https://rclone.org/install.sh | sudo bash ;;
esac

cd ~
clear

if [ -e "/home/plexuser/.config/rclone/rclone.conf" ]

then
  echo "Rclone already configured, skipping"
else
  echo "Please follow the instructions to setup Rclone"
  echo ""
  sudo rclone config
fi

# -------------------
# Installing Services
# -------------------

if [ -e "/etc/systemd/system/rclone.service" ]

then
  echo "Service already configured, skipping"
else
  sudo rsync -a /opt/GooPlex/scripts/etc/systemd/system/rclone.service /etc/systemd/system/rclone.service
  sudo systemctl enable rclone.service
  sudo systemctl daemon-reload
  source /opt/GooPlex/tasks/reboot.sh
fi

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
