#!/bin/bash

# FUNCTION="Generic"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Install
INSTALL(){
  /opt/GooPlex/install/apps/$FUNCTION-install.sh
}

# Update
UPDATE(){
  /opt/GooPlex/install/apps/$FUNCTION-update.sh
}

# Remove
REMOVE(){
  /opt/GooPlex/install/apps/$FUNCTION-remove.sh
}

# Exit
QUIT(){
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " G O O P L E X - Visit techperplexed.ga "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e " ${STD}"
  echo -e " ${LPURPLE}A${STD} - Install $FUNCTION"
  echo -e " ${LPURPLE}B${STD} - Update $FUNCTION"
  echo -e " ${LPURPLE}C${STD} - Remove $FUNCTION"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo -e " ${LPURPLE}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) INSTALL ;;
      [Bb]) UPDATE ;;
      [Cc]) REMOVE ;;
      [Zz]) QUIT ;;
      *) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
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
