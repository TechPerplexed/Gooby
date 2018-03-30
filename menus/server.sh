#!/bin/bash

FUNCTION="Maintain Server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Prepare Server
SERVER(){
  bash /opt/GooPlex/tasks/vpsupdate.sh
}

# Create New User
USER(){
  bash /opt/GooPlex/tasks/createuser.sh
}

# Additional Options
MISC(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Exit
QUIT(){
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
  echo -e " ${YELLOW}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${GREEN}A${STD} - Prepare Server"
  echo -e " ${GREEN}B${STD} - Create New User"
  echo -e " ${GREEN}C${STD} - Additional Options"
  echo -e " ${YELLOW}Z${STD} - Exit $FUNCTION"
  echo -e ""
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) SERVER ;;
      [Bb]) USER ;;
      [Cc]) MISC ;;
      [Zz]) QUIT ;;
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
