#!/bin/bash

FUNCTION="Maintain Server"

# ---------
# Variables
# ---------

source /opt/GooPlex/install/variables.sh
clear

# ------------
# Menu Options
# ------------

# Prepare Server
SERVER(){
  bash /opt/GooPlex/install/server/options/vpsupdate.sh
}

# Create New User
USER(){
  bash /opt/GooPlex/install/server/options/createuser.sh
}

# Additional Options
MISC(){
  bash /opt/GooPlex/install/errorpage.sh
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
  echo ""
  echo "----------------------------------------"
  echo " $FUNCTION"
  echo "----------------------------------------"
  echo ""
  echo -e "${GRN}A${STD} - Prepare Server"
  echo -e "${GRN}B${STD} - Create New User"
  echo -e "${GRN}C${STD} - Additional Options"
  echo -e "${YLW}Q${STD} - Quit/Exit $FUNCTION"
  echo ""
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
      [Cc]) MSIC ;;
      [Qq]) QUIT ;;
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
