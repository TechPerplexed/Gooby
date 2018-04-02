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

  # Creating backup
  echo -e "${LMAGENTA}Creating backup file...${STD}"
  sudo tar -cf /tmp/$(date +%F).tar.gz \
    /opt/Tautulli/config.ini \
    /opt/Tautulli/tautulli.db \
    /var/lib/plexmediaserver

  # Starting services
  echo -e "${CYAN}Starting services...${STD}"
  sudo service plexmediaserver start
  sudo systemctl start tautulli.service

  # Copying to Gdrive
  echo -e "${GREEN}Copying to Google drive...${STD}"
  sudo rclone copy /tmp/$(date +%F).* Gdrive:/Backup/$(hostname) -checksum --drive-chunk-size=64M
  sudo rm /tmp/$(date +%F).*
  echo -e "Done!"

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
