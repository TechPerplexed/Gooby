#!/bin/bash

clear

# ------------
# Menu Options
# ------------

# Install
INSTALL(){
  PERFORM="install"
  source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

# Update
UPDATE(){
  PERFORM="update"
  source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
}

# Remove
REMOVE(){
  PERFORM="remove"
  source /opt/GooPlex/install/apps/${TASK}-${PERFORM}.sh
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
  echo -e " $TASK"
  echo -e " ${STD}"
  echo -e " ${LPURPLE}A${STD} - Install $TASK"
  echo -e " ${LPURPLE}B${STD} - Update $TASK"
  echo -e " ${LPURPLE}C${STD} - Remove $TASK"
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
