#!/bin/bash

source /opt/Gooby/menus/variables.sh
source $CONFIGS/Docker/.env

# Update Gooby

sudo rm -r /opt/Gooby
sudo git clone -b rcleantest https://github.com/TechPerplexed/Gooby /opt/Gooby
sudo chmod +x -R /opt/Gooby/install
sudo chmod +x -R /opt/Gooby/menus
sudo chmod +x -R /opt/Gooby/scripts/cron
sudo rsync -a /opt/Gooby/install/gooby /bin
sudo chmod 755 /bin/gooby

sudo rsync -a /opt/Gooby/scripts/components/{00-AAA.yaml,01-proxy.yaml} $CONFIGS/Docker/components

# Shut everything down

cd $CONFIGS/Docker
/usr/local/bin/docker-compose down

sudo systemctl stop mergerfs
sudo systemctl stop rclonefs
sudo systemctl daemon-reload

# Update Rclone if possible

touch $TCONFIGS/rclonev
if [ $( cat $TCONFIGS/rclonev ) = "Stable" ]; then
	curl https://rclone.org/install.sh | sudo bash
elif [ $( cat $TCONFIGS/rclonev ) = "Beta" ]; then
	curl https://rclone.org/install.sh | sudo bash -s beta
fi

# Clean system Rclone leftovers

# Are mounts truly down?

mountpoint ${RCLONEMOUNT} > /dev/null
CODE=${?}
mountpoint ${MOUNTTO} > /dev/null
CODE=$[${CODE}+${?}]

while [ ${CODE} -lt 2 ]
do
	echo Waiting on mounts to drop...
	sleep 5
	mountpoint ${RCLONEMOUNT} > /dev/null
	CODE=${?}
	mountpoint ${MOUNTTO} > /dev/null
	CODE=$[${CODE}+${?}]
done

sudo rm -r ${RCLONEMOUNT} > /dev/null 2>&1
sudo rm -r ${MOUNTTO} > /dev/null 2>&1
rm ${LOGS}/*.? > /dev/null
echo -n > ${LOGS}/rclone.log

# Start Rclone and MergerFS

sudo systemctl start rclonefs
sleep 10
sudo systemctl start mergerfs

# Are mounts truly up?

mountpoint ${RCLONEMOUNT} > /dev/null
CODE=${?}
mountpoint ${MOUNTTO} > /dev/null
CODE=$[${CODE}+${?}]

while [ ${CODE} -ne 0 ]
do
        echo Waiting on mounts to be created...
        sleep 5
        mountpoint ${RCLONEMOUNT} > /dev/null
        CODE=${?}
        mountpoint ${MOUNTTO} > /dev/null
        CODE=$[${CODE}+${?}]
done

# Update and start containers

source /opt/Gooby/install/misc/environment-build.sh rebuild

/usr/local/bin/docker-compose pull
/usr/local/bin/docker-compose up --remove-orphans --build -d

# Clean Docker leftovers

docker system prune -a -f --volumes

cd ${CURDIR}

# Patching Server

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean
sudo apt-get autoremove

echo
echo "${GREEN}$(date) - Done! Your system should be back online${STD}"
echo

echo "${LYELLOW}Restoring permissions... this could take a few minutes${STD}"
echo

sudo chown -R $USER:$USER $TCONFIGS $HOME $CONFIGS/Certs $CONFIGS/Docker $CONFIGS/Security
