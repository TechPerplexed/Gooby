#!/bin/bash

FUNCTION="Main Menu"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Maintain Server
server(){
  /opt/GooPlex/menus/server.sh
}

# Install Apps
apps(){
  /opt/GooPlex/menus/apps.sh
}

# Additional Options
misc(){
  /opt/GooPlex/menus/misc.sh
}

# Exit
quit(){
  clear
  echo ""
  echo "----------------------------------------------"
  echo -e " Visit this menu any time by typing '${WHITE}gooplex${STD}' "
  echo "----------------------------------------------"
  echo ""
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${GREEN}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${GREEN}A${STD} - Maintain Server"
  echo -e " ${GREEN}B${STD} - Install/Update Applications"
  echo -e " ${GREEN}C${STD} - Additional Tasks"
  echo -e " ${LRED}Q${STD} - QUIT Main Menu"
  echo -e ""
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
