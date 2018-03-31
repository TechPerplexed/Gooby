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

sudo ufw allow 8181  # Tautulli

# ------------
# Dependencies
# ------------

# None

# -----------
# Main script
# -----------

# Execution

cd /opt/
clear
sudo git clone https://github.com/Tautulli/Tautulli.git
cd ~

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
