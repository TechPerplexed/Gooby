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
  /opt/GooPlex/install/misc/update.sh
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
  echo -e " $FUNCTION "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
  echo -e " ${CYAN}A${STD} - Update GooPlex"
#  echo -e " ${CYAN}B${STD} - Create Plex database backup"
#  echo -e " ${CYAN}C${STD} - Restore Plex database"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
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
