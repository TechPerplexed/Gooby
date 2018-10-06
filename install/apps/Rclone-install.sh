#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # ----------
  # Open ports
  # ----------

  # None

  # ------------
  # Dependencies
  # ------------

  sudo apt-get upgrade -y && sudo apt-get upgrade -y
  sudo -s apt-get -y install \
      unzip \
      curl \
      fuse \
  denyhosts at sudo software-properties-common
  
  # ------------------
  # Create directories
  # ------------------
  
  mkdir -p /home/plexuser/logs
  mkdir -p /home/plexuser/uploads
  sudo chown plexuser:plexuser -R /home/plexuser

  # -----------
  # Main script
  # -----------

  cd /tmp

  read -e -p "Release (R) or Beta installation (B)? " -i "R" choice

  case "$choice" in 
    b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
    * ) curl https://rclone.org/install.sh | sudo bash ;;
  esac

  cd ~
  clear

  echo "Please follow the instructions to setup Rclone"
  echo ""
  sudo rclone config

  # -------------------
  # Installing Services
  # -------------------

  if [ ! -e "/etc/systemd/system/rclone.service" ]
  then

    sudo rsync -a /opt/GooPlex/scripts/rclone.service /etc/systemd/system/rclone.service
    sudo systemctl enable rclone.service
    sudo systemctl daemon-reload
    sudo systemctl start rclone.service

  fi

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
