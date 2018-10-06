#!/bin/bash

clear
read -p "Are you sure you want to remove $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then

  echo -e "Coming soon!"

else

  echo -e "You chose ${YELLOW}not${STD} to remove $FUNCTION"

fi

PAUSE
