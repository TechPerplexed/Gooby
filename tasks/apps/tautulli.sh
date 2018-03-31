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

# None

# -----------
# Main script
# -----------

# Execution

sudo apt-get upgrade -y && sudo apt-get upgrade -y
sudo git clone https://github.com/Tautulli/Tautulli.git /opt/Tautulli

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
