#!/bin/bash

# ----------------
# Define variables
# ----------------

function="prepare vps"

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'

# Confirm

clear
read -p "Are you sure you want to $function (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# --------------------
# Main script function
# --------------------

# Dependencies

# Initial update

sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

sudo apt-get -y install \
  git \
  fail2ban \
  nano \
  unzip \
  wget \
  curl \
  ufw \
  socat \
  denyhosts at sudo software-properties-common

# Open port

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw --force enable

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

# Set timezone

clear
sudo dpkg-reconfigure tzdata

# ----------
# Finalizing
# ----------

# Clean up

else

  echo "You chose not to $function"

fi
