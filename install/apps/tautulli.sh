#!/bin/bash

FUNCTION="install or update Tautulli"

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

sudo ufw allow 8181

# ------------
# Dependencies
# ------------

sudo apt-get upgrade -y && sudo apt-get upgrade -y

# -----------
# Main script
# -----------

# Execution

cd /opt/
sudo git clone https://github.com/Tautulli/Tautulli.git

# -------------------
# Installing Services
# -------------------

if [ -e "/etc/systemd/system/tautulli.service" ]

then

echo "Service already configured, skipping"

else

sudo rsync -a /opt/GooPlex/scripts/services/tautulli.service /etc/systemd/system/tautulli.service
sudo systemctl enable tautulli.service
sudo systemctl daemon-reload

fi

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
