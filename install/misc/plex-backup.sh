#!/bin/bash

clear

# Explanation

echo -e "--------------------------------------------------"
echo -e " This will create a backup of Plex and Tautulli"
echo -e " The backup can be found in Google (Backup folder)"
echo -e "--------------------------------------------------"
echo ""

# Confirmation

read -p " Are you sure you want to ${PERFORM} ${TASK} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

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
  sudo rclone copy /tmp/$(date +%F).* Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
  sudo rm /tmp/$(date +%F).*
  echo -e "${WHITE}Done!${STD}"

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
