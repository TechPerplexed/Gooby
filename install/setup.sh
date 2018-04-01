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

if [ "$VERSION" != "16.04" ];
then

  # Confirmation

  clear
  echo -e "you are running version ${LRED}$VERSION${STD}"
  echo -e "GooPlex has only been tested on ${CYAN}Ubuntu 16.04${STD} - proceed at your own risk"
  echo ""
  read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
  echo ""

  if [[ $REPLY =~ ^[Yy]$ ]]
  then

    echo -e "${LRED}Ok, proceeding...${STD}" && sleep 2

  else

    echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"
    echo -e "Exiting..."
    echo ""
    exit 0

  fi

fi

gooplex
