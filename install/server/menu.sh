#!/bin/bash

# ----------------
# Define variables
# ----------------

function="Prepare Server"

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

# Update Ubuntu and Install Vital Services
vpsupdate (){
  clear
  bash /opt/GooPlex/install/server/choices/vpsupdate.sh
  pause
}

# Change Root Password
rootpw(){
  clear
  bash /opt/GooPlex/install/server/choices/rootpw.sh
  pause
}

# Create Plexuser
usercreate(){
  clear
  bash /opt/GooPlex/install/server/usercreate.sh
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
  echo -e "${GRN}1.${STD} Update Ubuntu and Install Vital Services"
  echo -e "${GRN}2.${STD} Change Root Password"
  echo -e "${GRN}3.${STD} Create Plexuser"
  echo -e "${GRN}4.${STD} Future"
  echo -e "${YLW}5.${STD} Exit $function"
  echo ""
}

# Read input from the keyboard and take a action
read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      1) vpsupdate ;;
      2) rootpw ;;
      3) usercreate ;;
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
