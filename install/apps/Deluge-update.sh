#!/bin/bash

clear
read -p "Are you sure you want to $PERFORM $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then

  sudo apt-get upgrade -y && sudo apt-get upgrade -y
  echo -e "${FUNCTION} has been updated to the latest version"

else

  echo -e "You chose ${YELLOW}not${STD} to $PERFORM $FUNCTION"

fi

PAUSE
