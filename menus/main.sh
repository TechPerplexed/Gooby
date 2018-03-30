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
  bash /opt/GooPlex/menus/server.sh
}

# Install Apps
apps(){
  bash /opt/GooPlex/menus/apps.sh
}

# Additional Options
misc(){
  bash /opt/GooPlex/menus/misc.sh
}

# Exit
quit(){
  clear
  echo ""
  echo "----------------------------------------------"
  echo " Visit this menu any time by typing 'gooplex' "
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
  echo -e " ${GREEN}B${STD} - Install Apps"
  echo -e " ${GREEN}C${STD} - Additional Options"
  echo -e " ${YELLOW}Q${STD} - Quit $FUNCTION"
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
