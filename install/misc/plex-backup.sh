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

  # Stopping services
  sudo systemctl stop tautulli.service
  sudo service plexmediaserver stop

  # Creating backup
  sudo tar -cf /tmp/$(hostname).$(date +%F).tar.gz \
    /opt/Tautulli/config.ini \
    /opt/Tautulli/tautulli.db \
    /var/lib/plexmediaserver

  # Starting services
  sudo service plexmediaserver start
  sudo systemctl start tautulli.service

  # Copying to Gdrive
  sudo rclone copy /tmp/$(hostname).* Gdrive:/Backup -v --checksum --drive-chunk-size=64M
  sudo rm /tmp/$(hostname).*
  echo -e "Done!"

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
