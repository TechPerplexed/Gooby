#!/bin/bash

# ----------------
# Define variables
# ----------------

function="change the root password"

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'

pause(){
  read -p "Press [Enter] key to return to the menu..." fackEnterKey
}

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

# Open port

# Installing

  clear
  echo -e "Use a password generator to create a very strong root password"
  echo ""
  sudo -s passwd

# ----------
# Finalizing
# ----------

# Clean up

else

  echo "You chose not to $function"

fi

pause
