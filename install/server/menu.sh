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
updatesvr (){
  clear
  bash /opt/GooPlex/install/server/choices/updatesvr.sh
  pause
}

# Update Ubuntu
rootpw(){
  clear
  bash /opt/GooPlex/install/server/choices/rootpw.sh
  pause
}

# Install vital apps
misc(){
  clear
  bash /opt/GooPlex/install/server/vitalapps.sh
  pause
}

# Future use
future(){
  clear
  echo "For future use"
  pause
}

# Exit menu
main(){
  clear
  echo ""
  echo "-------------------------------"
  echo " Returning to the main menu... "
  echo "-------------------------------"
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
  echo -e "${GRN}4.${STD} Future"
  echo -e "${YLW}5.${STD} Exit $function"
  echo ""
}

# Read input from the keyboard and take a action
read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      1) updatesvr ;;
      2) rootpw ;;
      3) misc ;;
      4) future ;;
      5) main ;;
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
