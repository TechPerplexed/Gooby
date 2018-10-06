#!/bin/bash

clear

# Explanation

echo -e "-----------------------------------------------------"
echo -e " This will ${PERFORM} ${FUNCTION}"
echo -e "        You can run this as often as you like!       "
echo -e "-----------------------------------------------------"
echo ""

# Confirmation

read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  # Main script

  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get dist-upgrade -y
  sudo apt autoremove -y
  sudo apt autoclean
  sudo apt-get autoremove
  
  echo -e "${LMAGENTA}"
  echo -e "--------------------------------------------------"
  echo -e " ${PERFORM} $FUNCTION completed"
  echo -e "--------------------------------------------------"
  echo -e "${STD}"

else

  echo ""
  echo -e "--------------------------------------------------"
  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"
  echo -e "--------------------------------------------------"
  echo ""

fi

PAUSE
