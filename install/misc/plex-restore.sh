#!/bin/bash

FUNCTION="backup Plex and Tautulli to Google"

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
  echo -e "Plex will be unavailable during the backup"
  echo -e "The backup can take several hours, depending on the size"
  echo -e "Please don't exit PuTTY until it's done!"
  echo ""

  # Execution

  echo -e "${YELLOW}Stopping services...${STD}"
  sudo systemctl stop tautulli.service
  sudo service plexmediaserver stop

  # Restoring backup
  echo -e "${LMAGENTA}Coming soon...${STD}"
  
  # Starting services
  echo -e "${CYAN}Starting services...${STD}"
  sudo service plexmediaserver start
  sudo systemctl start tautulli.service

  # Finalizing

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
