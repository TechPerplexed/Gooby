#!/bin/bash

FUNCTION="initialize server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# Explanation

echo -e "------------------------------------------------------"
echo -e " This will initalize the server with vital apps, "
echo -e "             Set the time zone and"
echo -e "       ${WHITE}Optionally${STD} change the root password. "
echo -e "    You probably only need to run this ${WHITE}once${STD}!"
echo -e "------------------------------------------------------"
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

    sudo apt-get upgrade -y && sudo apt-get upgrade -y

    # Set language
    
    sudo update-locale LANG="en_US.UTF-8"

    # Install unattended upgrades

    sudo apt-get -y install unattended-upgrades

    if [[ ! -f /etc/apt/apt.conf.d/20auto-upgrades.bak ]]; then
        sudo cp /etc/apt/apt.conf.d/20auto-upgrades /etc/apt/apt.conf.d/20auto-upgrades.bak
        sudo rm /etc/apt/apt.conf.d/20auto-upgrades
        echo "APT::Periodic::Update-Package-Lists \"1\";
        APT::Periodic::Download-Upgradeable-Packages \"1\";
        APT::Periodic::AutocleanInterval \"30\";
        APT::Periodic::Unattended-Upgrade \"1\";" | sudo tee --append /etc/apt/apt.conf.d/20auto-upgrades
    fi

    # Install apps

    sudo -s apt-get -y install \
      git \
      fail2ban \
      nano \
      unzip \
      wget \
      curl \
      ufw \
      socat \
      acl \
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

  echo ""
  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
