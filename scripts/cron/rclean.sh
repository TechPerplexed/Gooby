#!/bin/bash

source /opt/Gooby/menus/variables.sh

echo
echo "${LYELLOW}${LYELLOW}Taking containers down${STD}"
echo

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

echo
echo "${LYELLOW}Taking services down${STD}"
echo

sudo systemctl daemon-reload

sudo systemctl stop gooby

/bin/fusermount -uz ${RCLONEMOUNT}
/bin/fusermount -uz ${MOUNTTO}

sudo rmdir ${RCLONEMOUNT} > /dev/null 2>&1
sudo rmdir ${MOUNTTO} > /dev/null 2>&1

echo
echo "${LYELLOW}Making sure components are up to date${STD}"
echo

sudo rm -r /opt/Gooby
sudo git clone -b master https://github.com/TechPerplexed/Gooby /opt/Gooby
sudo chmod +x -R /opt/Gooby/install
sudo chmod +x -R /opt/Gooby/menus
sudo chmod +x -R /opt/Gooby/scripts/cron
sudo rsync -a /opt/Gooby/install/gooby /bin
sudo chmod 755 /bin/gooby

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

echo
echo "${LYELLOW}Update Rclone${STD}"
echo

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

echo
echo "${LYELLOW}Checking for updated containers${STD}"
echo

sudo mkdir ${MOUNTTO}
sudo chown -R $USER:$USER /mnt/{MOUNTTO}

sudo systemctl start gooby

echo
echo "${LYELLOW}Bringing system back online${STD}"
echo

source /opt/Gooby/install/misc/environment-build.sh rebuild
/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}

echo
echo "${LYELLOW}Pruning old volumes${STD}"
echo

docker system prune -f --volumes

echo
echo "${LYELLOW}${LYELLOW}Patching server${STD}"
echo

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean
sudo apt-get autoremove

echo
echo "${GREEN}Your system should be back online${STD}"
echo
echo "${LYELLOW}Restoring permissions... this could take a few minutes${STD}"
echo

sudo chown -R $USER:$USER $CONFIGS
sudo chown -R $USER:$USER $TCONFIGS
sudo chown -R $USER:$USER $HOME
cd ${CURDIR}
