#!/bin/bash

FUNCTION="remove NZBGet"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear
read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then

echo -e "Coming soon!"

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
