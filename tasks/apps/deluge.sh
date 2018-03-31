#!/bin/bash

FUNCTION="install or update Deluger"

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

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
