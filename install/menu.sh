#!/bin/bash

# ----------------
# Define variables
# ----------------

function="GooPlex Main Menu"

STD='\033[0m'
RED='\033[00;31m'
GRN='\033[00;32m'
YLW='\033[00;33m'

# --------------------
# Main script function
# --------------------

clear

# Installing

# Prepare Server
server(){
  bash /opt/GooPlex/install/server/menu.sh
}

# Install Apps
apps(){
  bash /opt/GooPlex/install/apps/menu.sh
}

# Additional Options
misc(){
  bash /opt/GooPlex/install/misc/menu.sh
}

# Exit
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
  echo -e "${GRN}1.${STD} Prepare Server"
  echo -e "${GRN}2.${STD} Install Apps"
  echo -e "${GRN}3.${STD} Additional Options"
  echo -e "${YLW}4.${STD} Exit $function"
  echo ""
}

# Read input from the keyboard and take a action
read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      1) server ;;
      2) apps ;;
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
