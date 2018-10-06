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
  FUNCTION="Update GooPlex"
  source /opt/GooPlex/install/misc/update.sh
}

# Plex Backup
PBACKUP(){
  /opt/GooPlex/install/misc/plex-backup.sh
}


# Plex Restore
PRESTORE(){
  /opt/GooPlex/install/misc/plex-restore.sh
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
  echo -e " G O O P L E X - Visit techperplexed.ga "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e " ${STD}"
  echo -e " ${CYAN}A${STD} - Update GooPlex"
  echo -e " ${CYAN}B${STD} - Backup Plex and Tautulli"
  echo -e " ${CYAN}C${STD} - Restore Plex and Tautulli"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo -e " ${CYAN}"
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
      [Aa]) SERVER ;;
      [Bb]) PBACKUP ;;
      [Cc]) PRESTORE ;;
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
