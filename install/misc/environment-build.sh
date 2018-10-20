#!/bin/bash

source /opt/GooPlex/menus/variables.sh

DOCKERHOME=$CONFIGS/Docker
sudo mkdir -p $DOCKERHOME/components
sudo chown -R $USER:$USER $CONFIGS
ENV=${DOCKERHOME}/.env
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
echo "#    for GooPlex v$VERSION   #" >> ${ENV}
echo "###########################" >> ${ENV}
echo >> ${ENV}
echo "HOME=$HOME" >> ${ENV}
echo "USERID=$(id -u)" >> ${ENV}
echo "GROUPID=$(id -g)" >> ${ENV}
echo "IP=$(curl ifconfig.me)" >> ${ENV}
echo "TIMEZONE=$(cat /etc/timezone)" >> ${ENV}
echo "CONFIGS=$CONFIGS" >> ${ENV}
echo "DOWNLOADS=${HOME}/Downloads" >> ${ENV}
echo "GOOGLE=/media/Google" >> ${ENV}
echo "MYDOMAIN=$(cat $CONFIGS/.config/mydomain)" >> ${ENV}
echo "MYEMAIL=$(cat $CONFIGS/.config/myemail)" >> ${ENV}
echo "MEDIA=/media/Google" >> ${ENV}
echo "TV=/media/Google/TV Shows" >> ${ENV}
echo "MOVIES=/media/Google/Movies" >> ${ENV}
echo "RCLONETARGET=Gdrive" >> ${ENV}
echo "ORGMENU=menu" >> ${ENV}

cat ${CONFIGS}/Docker/components/??-* > ${DOCKERHOME}/docker-compose.yaml
echo done
