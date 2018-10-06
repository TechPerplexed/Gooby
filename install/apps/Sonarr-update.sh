#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  clear
  echo ""
  echo -e "${FUNCTION} can't be updated through this menu"
  echo -e "You can update it from the app itself."

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
