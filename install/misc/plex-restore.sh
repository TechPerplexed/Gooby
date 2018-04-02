#!/bin/bash

FUNCTION="restore Plex and Tautulli database"

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
  echo -e "Plex will be unavailable during the restoring process"
  echo -e "This can take several hours, depending on the size"
  echo -e "Please don't exit PuTTY until it's done!"
  echo ""

  # Execution

  cd /tmp
  read -e -p "Host name to restore: " -i "$(hostname)" filename
  read -e -p "File date to restore: " -i "$(date +%F)" filedate
  
  echo -e "${GREEN}Copying from Google drive...${STD}"
  sudo rclone copy Gdrive:/Backup/$filename/$filedate.tar.gz /tmp --checksum --drive-chunk-size=64M

  if [ -e "/tmp/$filedate.tar.gz" ]

  then
    echo -e "${LBLUE}File downloaded, proceeding...${STD}"
  else
    clear
    echo "$filename/$filedate.tar.gz not found on Google!"
    echo "Please try again"
    echo "Exiting script..."
    PAUSE
    exit
  fi
  
   # Execution

  echo -e "${LRED}Stopping services...${STD}"
  sudo service plexmediaserver stop
  sudo systemctl stop tautulli.service

  # Replacing Plex vanilla with Plex backup
  
  echo -e "${LMAGENTA}Restoring file...${STD}"
  sudo mv /var/lib/plexmediaserver /tmp/plexmediaserver
  sudo tar -xf /tmp/$filedate.tar.gz -C /

  # Starting services
  
echo -e "${YELLOW}Starting services...${STD}"
  sudo chown -R plex:plex /var/lib/plexmediaserver
  sudo service plexmediaserver start
  sudo systemctl start tautulli.service

  # Cleaning up

  echo ""
  echo -e "${CYAN}Finished restoring${STD}"
  echo -e "${WHITE}Make sure${STD} you check if Plex is running properly before you remove the old files!"
  echo ""
  read -e -p "Remove old Plex installation (y/N)? "  -n 1 -r
  echo ""

  case "$choice" in
    y|Y ) sudo rm -r /tmp/plexmediaserver;;
    * ) echo "Your old installation is available at /tmp/plexmediaserver until you reboot";;
  esac

  sudo rm /tmp/$filedate.*
  cd ~

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
