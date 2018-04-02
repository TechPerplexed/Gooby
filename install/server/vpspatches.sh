#!/bin/bash

FUNCTION="run server update"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# Explanation

echo -e "-----------------------------------------------------"
echo -e " This will update the server with the latest patches "
echo -e "        You can run this as often as you like!       "
echo -e "-----------------------------------------------------"
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

else

  echo ""
  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
