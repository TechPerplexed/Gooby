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

# Maintain Server
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
  echo -e "${GRN}A${STD} - Maintain Server"
  echo -e "${GRN}B${STD} - Install Apps"
  echo -e "${GRN}C${STD} - Additional Options"
  echo -e "${YLW}Q${STD} - Quit/exit $FUNCTION"
  echo ""
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) server ;;
      [Bb]) apps ;;
      [Cc]) misc ;;
      [Qq]) quit ;;
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
