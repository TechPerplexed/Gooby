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

  sudo rclone copy Gdrive:/Backup/$filename.$filedate.tar.gz /tmp --checksum --drive-chunk-size=64M

  if [ -e "/tmp/$filename.$filedate.tar.gz" ]

  then
    echo "Proceeding..."
  else
    clear
    echo "$filename.$filedate.tar.gz not found on Google!"
    echo "Please try again"
    echo "Exiting script..."
    PAUSE
    exit
  fi

  cd ~

  # Replacing Plex vanilla with Plex backup

  sudo mv /var/lib/plexmediaserver /var/lib/plexmediaserver-vanilla
  sudo tar -xvf /tmp/$filename.$filedate.tar.gz -C /

  # Starting services

  sudo chown -R plex:plex /var/lib/plexmediaserver
  sudo service plexmediaserver start
  sudo systemctl start plexpy.service

  # Cleaning up

  echo -e "Make sure you check Plex is running before you remove the old files!"
  echo ""
  read -e -p "Remove old Plex installation (Y/n)? " -i "n" choice
  echo ""

  case "$choice" in
    y|Y ) sudo rm -r /var/lib/plexmediaserver-vanilla;;
    * ) echo "Your old installation is available at /var/lib/plexmediaserver-vanilla";;
  esac

  sudo rm /tmp/$filename.*
  cd ~

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
