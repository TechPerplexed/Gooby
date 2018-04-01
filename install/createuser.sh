#!/bin/bash

FUNCTION="create a new user"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear
echo -e "New user ${CYAN}plexuser${STD} needs to be created now."
echo ""
read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

# Create user

PU=plexuser

sudo -s adduser $PU

sudo -s usermod -a -G sudo $PU
sudo -s echo -e "$PU\tALL=(ALL)\tNOPASSWD:ALL" > /etc/sudoers.d/$PU
sudo -s chmod 0440 /etc/sudoers.d/$PU

clear
echo -e "${GREEN}"
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e " You should now be switched to ${YELLOW}plexuser${GREEN} "
echo -e "    Type ${WHITE}gooplex${GREEN} to access the menu."
echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo -e "${STD}"

su $PU

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"
  echo -e "Exiting..."
  echo ""
  exit 0

fi

PAUSE
