#!/bin/bash

FUNCTION="Additional Tasks"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Update GooPlex
SERVER(){
  bash /opt/GooPlex/install/update.sh
}

# Coming soon
MISC1(){
  bash /opt/GooPlex/menus/errorpage.sh
}

# Additional Options
MISC2(){
  bash /opt/GooPlex/menus/errorpage.sh
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
  echo -e " ${CYAN}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${GREEN}A${STD} - Update GooPlex"
  echo -e " ${GREEN}B${STD} - Coming Soon"
  echo -e " ${GREEN}C${STD} - Coming Soon"
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
      [Bb]) MISC1 ;;
      [Cc]) MISC2 ;;
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
