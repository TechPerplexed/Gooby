#!/bin/bash

FUNCTION="install GooPlex"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

sudo chmod +x -R /opt/GooPlex/install
sudo chmod +x -R /opt/GooPlex/menus
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod 755 /bin/gooplex

lsb_release -r -s > /tmp/version
VERSION=$( cat /tmp/version )

if [ "$VERSION" != "18.04" ];
then

  # Confirmation

  clear
  echo -e "You are running version ${LRED}$VERSION${STD} of Linux"
  echo -e "GooPlex has been tested on ${CYAN}16.04${STD} and ${CYAN}18.04${STD}"
  echo -e "Proceed at your own risk!"
  echo ""
  read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]
  then

    echo -e "${LRED}Ok, proceeding...${STD}" && sleep 2

  else

clear
  echo ""
  echo "----------------------------------------------"
  echo -e " You chose ${YELLOW}not${STD} to $FUNCTION"
  echo -e " Continue any time by typing '${WHITE}gooplex${STD}' "
  echo -e " Exiting..."
  echo "----------------------------------------------"
  echo ""
  exit

    echo ""
    exit 0

  fi

fi

gooplex
