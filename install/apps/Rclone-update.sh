#!/bin/bash

clear
read -p "Are you sure you want to ${PERFORM} ${FUNCTION} (y/N)? " -n 1 -r
echo ""

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

  cd /tmp

  read -e -p "Release (R) or Beta installation (B)? " -i "R" choice

  case "$choice" in 
    b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
    * ) curl https://rclone.org/install.sh | sudo bash ;;
  esac

  cd ~

else

  echo -e "You chose ${YELLOW}not${STD} to ${PERFORM} ${FUNCTION}"

fi

PAUSE
