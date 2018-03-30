#!/bin/bash

FUNCTION="update VPS and prepare server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# Explanation

echo -e "This will update the server with the latest patches, set the time zone and"
echo -e "${WHITE}Optionally${STD} change the root password."
echo ""

# Confirmation

read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

# Initial update

sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

# Set language

test "$LANG" = "en_US.UTF-8" \
    || echo "en_US.UTF-8 UTF-8" >>/etc/locale.gen \
    && locale-gen --lang en_US.UTF-8

# Install unattended upgrades

sudo apt-get -y --force-yes install unattended-upgrades

if [[ ! -f /etc/apt/apt.conf.d/20auto-upgrades.bak ]]; then
    sudo cp /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades.bak
    sudo rm /etc/apt/apt.conf.d/20auto-upgrades
    echo "APT::Periodic::Update-Package-Lists \"1\";
    APT::Periodic::Download-Upgradeable-Packages \"1\";
    APT::Periodic::AutocleanInterval \"30\";
    APT::Periodic::Unattended-Upgrade \"1\";" | sudo tee --append /etc/apt/apt.conf.d/20auto-upgrades
fi

# Install apps

sudo apt-get -y install \
  git \
  fail2ban \
  nano \
  unzip \
  wget \
  curl \
  ufw \
  socat \
  fuse \
  denyhosts at sudo software-properties-common

  
# Configure firewall

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

# Set timezone

clear
sudo dpkg-reconfigure tzdata

# ----------
# Finalizing
# ----------

# Change root password

clear
read -p "Change root password (y/N)? " -n 1 -r
echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]
  then

    clear
    echo -e "Create a ${CYAN}very strong${STD} root password"
    echo -e "The best way is to use a ${CYAN}password generator${STD}"
    echo -e "Then make sure to store your password in a ${CYAN}safe place${STD}"
    echo ""

    sudo -s passwd
  
  else

    echo -e "You chose ${YELLOW}not${STD} to change the root password."
  
  fi

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
