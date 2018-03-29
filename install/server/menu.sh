#!/bin/bash

# ----------------
# Define variables
# ----------------

function="Server Maintenance"

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'

pause(){
  read -p "Press [Enter] key to return to the menu..." fackEnterKey
}

# --------------------
# Main script function
# --------------------

# Dependencies

# Open port

# Installing

# Install and maintain Apps
apps(){
  clear
  bash /opt/GooPlex/install/apps/menu.sh
  pause
}

# Server maintenance
server(){
  clear
  bash /opt/GooPlex/install/server/menu.sh
  pause
}

# Additional options
misc(){
  clear
  bash /opt/GooPlex/install/server/menu.sh
  pause
}

# Exit menu
quit(){
  clear
  echo ""
  echo "---------------------------------------------"
  echo " Visit the menu any time by typing 'gooplex' "
  echo "---------------------------------------------"
  echo ""
  exit
}

# Function to display menus
show_menus() {
  clear
  echo ""
  echo "---------------------------------------------"
  echo " $function "
  echo "---------------------------------------------"
  echo ""
  echo -e "${GRN}1.${STD} Install and maintain Apps"
  echo -e "${GRN}2.${STD} Server maintenance"
  echo -e "${GRN}3.${STD} Additional options"
  echo -e "${YLW}4.${STD} Exit $function"
  echo ""
}

# Read input from the keyboard and take a action
read_options(){
  local choice
    read -p "Choose option [ 1 - 4 ] " choice
    case $choice in
      1) apps ;;
      2) server ;;
      3) misc ;;
      4) quit ;;
      *) echo -e "${RED}Please select a valid option${STD}" && sleep 2
    esac
}
 
# ----------
# Finalizing
# ----------

trap '' SIGINT SIGQUIT SIGTSTP

while true
do 
  show_menus
  read_options
done
