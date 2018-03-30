#!/bin/bash

FUNCTION="GooPlex Main Menu"

# ---------
# Variables
# ---------

source /opt/GooPlex/install/variables.sh
clear

# ------------
# Menu Options
# ------------

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

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo ""
  echo "----------------------------------------"
  echo " $FUNCTION"
  echo "----------------------------------------"
  echo ""
  echo -e "${GRN}1.${STD} Prepare Server"
  echo -e "${GRN}2.${STD} Install Apps"
  echo -e "${GRN}3.${STD} Additional Options"
  echo -e "${YLW}4.${STD} Exit $function"
  echo ""
}

# ------------
# Read Choices
# ------------

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
