#!/bin/bash

PERFORM="install"
TASK="GooPlex"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

sudo chmod +x -R /opt/GooPlex/install
sudo chmod +x -R /opt/GooPlex/menus
sudo rsync -a /opt/GooPlex/install/gooplex /bin
sudo chmod 755 /bin/gooplex
sudo chown -R $USER:$USER /opt/GooPlex

lsb_release -r -s > /tmp/version
VERSION=$( cat /tmp/version )

if [ "$VERSION" != "18.04" ]; then

	CONFIRMATION

	if [[ $REPLY =~ ^[Yy]$ ]]; then

		echo -e "${LRED}Ok, proceeding...${STD}" && sleep 2

	else

		CANCELTHIS
		MENUVISIT
		exit 0

	fi

fi

gooplex
