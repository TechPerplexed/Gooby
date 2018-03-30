#!/bin/bash

FUNCTION="create a new user"

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
echo -e "Creating the user to do all ${CYAN}daily tasks${STD}"
echo ""

# Execution

# Create user

read -e -p "Your preferred username: " -i "plexuser" plexuser

adduser -s $plexuser

usermod -a -G sudo $plexuser
echo -e "$plexuser\tALL=(ALL)\tNOPASSWD:ALL" > /etc/sudoers.d/$plexuser
chmod 0440 /etc/sudoers.d/$plexuser

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
