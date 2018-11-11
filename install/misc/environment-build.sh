#!/bin/bash

source /opt/Gooby/menus/variables.sh

ENV=$CONFIGS/Docker/.env
touch ${ENV}

# Load existing variables and use them as defaults, if available

	while IFS='' read -r line || [[ -n "${line}" ]]; do
		newline=$(echo ${line} | sed 's/=/&\"/g; s/:$//')\"
		eval ${newline} > /dev/null 2>&1
	done < ${ENV}

if [[ ${1,,} != "rebuild" ]]; then

	echo Checking system dependencies... This might be a minute.
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null 2>&1
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /dev/null 2>&1
	apt-get update > /dev/null 2>&1
	sudo apt-get install -y docker-ce dialog > /dev/null 2>&1
	sudo usermod -aG docker ${USER} > /dev/null 2>&1
	sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
	sudo chmod +x /usr/local/bin/docker-compose
	echo "Creating configuration file..."

fi

echo "###########################" > ${ENV}
echo "#  Environment variables  #" >> ${ENV}
echo "#     for Gooby v$VERSION    #" >> ${ENV}
echo "###########################" >> ${ENV}
echo >> ${ENV}
echo "CONFIGS=${CONFIGS}" >> ${ENV}
echo "TCONFIGS=${TCONFIGS}" >> ${ENV}
echo "HOMEDIR=$HOME" >> ${ENV}
echo "LOGS=$HOME/logs" >> ${ENV}
echo "USERID=$(id -u)" >> ${ENV}
echo "GROUPID=$(id -g)" >> ${ENV}
echo "USERNAME=$USER" >> ${ENV}
echo "GROUPNAME=$USER" >> ${ENV}
echo "IP=$(curl ifconfig.me)" >> ${ENV}
echo "TIMEZONE=$(cat /etc/timezone)" >> ${ENV}
echo "MYDOMAIN=$(cat ${CONFIGS}/.config/mydomain)" >> ${ENV}
echo "MYEMAIL=$(cat ${CONFIGS}/.config/myemail)" >> ${ENV}
echo "ORGMENU=menu" >> ${ENV}
echo "RCLONESERVICE=$(cat ${CONFIGS}/.config/rcloneservice)" >> ${ENV}
echo "RCLONEFOLDER=$(cat ${CONFIGS}/.config/rclonefolder)" >> ${ENV}
echo "RCLONEMOUNT=/mnt/rclone" >> ${ENV}
echo "MOUNTTO=/mnt/google" >> ${ENV}
echo "UPLOADS=/mnt/uploads" >> ${ENV}
echo "GOOGLE=/mnt/google" >> ${ENV}
echo "MEDIA=/mnt/google" >> ${ENV}
echo "MOVIES=/mnt/google/Movies" >> ${ENV}
echo "TV=/mnt/google/TV" >> ${ENV}
echo "DOWNLOADS=${HOMEDIR}/Downloads" >> ${ENV}
[[ -f "${TCONFIGS}/plexclaim" ]] && echo "PLEXCLAIM=$(cat ${TCONFIGS}/plexclaim)" >> ${ENV}

cat ${CONFIGS}/Docker/components/??-* > ${CONFIGS}/Docker/docker-compose.yaml
echo done

if [ -e /etc/systemd/system/rclone.service ]; then
	sudo sed -i "s/media/mnt/g" /etc/systemd/system/rclone.service
	sudo sed -i "s/Google/google/g" /etc/systemd/system/rclone.service
	sudo systemctl daemon-reload
	sudo systemctl restart rclone.service	
fi
