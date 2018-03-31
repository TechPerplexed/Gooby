#!/bin/bash

FUNCTION="install or update Organizr"

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

sudo ufw allow 80

# ------------
# Dependencies
# ------------

sudo apt-get upgrade -y && sudo apt-get upgrade -y

sudo apt-get -y install \
  python-pip \
  denyhosts at sudo software-properties-common


# None

# -----------
# Main script
# -----------

# Execution

sudo git clone https://github.com/elmerfdz/OrganizrInstaller /opt/OrganizrInstaller
cd /opt/OrganizrInstaller/ubuntu/oui
clear
sudo bash ou_installer.sh
cd ~

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
