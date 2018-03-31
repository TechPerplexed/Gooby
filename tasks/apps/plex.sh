#!/bin/bash

FUNCTION="install or update Plex"

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

sudo ufw allow 32400

# ------------
# Dependencies
# ------------

# None

# -----------
# Main script
# -----------

# Explanation

clear
echo -e "Please read the options carefully and follow the instructions"
echo ""

# Execution

if [ -d "/var/lib/plexmediaserver" ];

then

  /opt/plexupdate/extras/installer.sh

else

  cd /tmp
  bash -c "$(wget -qO - https://raw.githubusercontent.com/mrworf/plexupdate/master/extras/installer.sh)"
  cd ~

fi

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
