#!/bin/bash

FUNCTION="Reboot server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear

REBOOT(){
  echo " This installation requires you to reboot before proceeding! "
  echo ""

  read -e -p "Reboot now? (Y/n) " -i "Y" choice

  case "$choice" in 
    y|Y ) sudo reboot;;
    * ) echo "You will need to reboot manually!";;
esac
}
