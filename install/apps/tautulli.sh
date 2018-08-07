#!/bin/bash

FUNCTION="install Tautulli"

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

  if [ ! -d "/opt/Tautulli" ]
  then

    # ----------
    # Open ports
    # ----------

    sudo ufw allow 8181

    # ------------
    # Dependencies
    # ------------

    sudo apt-get upgrade -y && sudo apt-get upgrade -y

    sudo -s apt-get -y install \
      git-core \
      python3-setuptools-git \
      denyhosts at sudo software-properties-common

    # -----------
    # Main script
    # -----------

    # Execution

    cd /opt/
    sudo git clone https://github.com/Tautulli/Tautulli.git
    sudo chown plexuser:plexuser -R /opt/Tautulli
  
  else
  
    clear
    echo -e "Tautulli is already installed!"
    echo -e "You can update it from within the application itself."
 
  fi

  if [ ! -e "/etc/systemd/system/tautulli.service" ]
  then

    # -------------------
    # Installing Services
    # -------------------

    sudo rsync -a /opt/GooPlex/scripts/tautulli.service /etc/systemd/system/tautulli.service
    sudo systemctl enable tautulli.service
    sudo systemctl daemon-reload
    sudo systemctl start tautulli.service

  fi

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
