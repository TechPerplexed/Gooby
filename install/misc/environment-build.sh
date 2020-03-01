#!/bin/bash

source /opt/Gooby/menus/variables.sh

ENV=${CONFIGS}/Docker/.env
touch ${ENV}

# Since Docker processes " as part of the paths, we don't actually store it in the variables.  However, BASH does require
#	the " if the string is going to have odd characters.  As a result, we have to load the existing environment line
#	by line and insert the " around the values.

# Load existing variables and use them as defaults, if available
touch cat /var/local/Gooby/useragent
echo ${USER} >/var/local/Gooby/useragent
uagentrandom="$(cat /var/local/Gooby/useragent)"
if [[ "$uagentrandom" == ${USER} || "$uagentrandom" == "" || "$uagentrandom" == "rclone/v1.*" ]]; then
    randomagent=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
    uagent=$(cat /var/plexguide/uagent)
    echo "$randomagent" >/var/local/Gooby/useragent
    echo $(sed -e 's/^"//' -e 's/"$//' <<<$(cat /var/plexguide/uagent)) >/var/local/Gooby/useragent; fi

while IFS='' read -r line || [[ -n "${line}" ]]; do
	newline=$(echo ${line} | sed 's/=/&\"/g; s/:$//')\"
	eval ${newline} > /dev/null 2>&1
done < ${ENV}

if [[ ${1,,} != "rebuild" ]]; then
	echo "Creating configuration file..."
fi

cat > ${ENV} << EOF

###########################
#  Environment variables  #
#     for Gooby v${VERSION}    #
###########################

APILOG=${LOGS}/api.log
CF_EMAIL=$(cat ${CONFIGVARS}/cf_email)
CF_KEY=$(cat ${CONFIGVARS}/cf_key)
CONFIGS=/var/local/Gooby
CONFIGVARS=${CONFIGS}/Docker/.config
CURDIR=$(pwd)
DOWNLOADS=${HOMEDIR}/Downloads
GOOBYBRANCH=$(cat ${CONFIGVARS}/goobybranch)
GOOGLE=/mnt/google
GROUPID=$(id -g)
GROUPNAME=${USER}
HOMEDIR=${HOME}
IP=$(curl ifconfig.me)
LOGS=${HOME}/logs
MEDIA=/mnt/google
ORGMENU=menu
MOUNTTO=/mnt/google
MYDOMAIN=$(cat ${CONFIGVARS}/mydomain)
MYEMAIL=$(cat ${CONFIGVARS}/myemail)
PLEXCLAIM=$(cat ${CONFIGVARS}/plexclaim)
PROXYVERSION=$(cat ${CONFIGVARS}/proxyversion)
RCLONEFOLDER=$(cat ${CONFIGVARS}/rclonefolder)
RCLONEHOME=${HOME}/.config/rclone
RCLONEMOUNT=/mnt/rclone
RCLONEPASSWORD=Go0by
RCLONESERVICE=$(cat ${CONFIGVARS}/rcloneservice)
RCLONEUSERNAME=gooby
SERVER=$(hostname)
TIMEZONE=$(cat /etc/timezone)
UNSYNCED=/mnt/local
UPLOADS=/mnt/uploads
USERID=$(id -u)
USERNAME=${USER}
VERSION=$(cat ${CONFIGVARS}/version)
USERAGENT=$(cat /var/local/Gooby/useragent)
DIR_CACHE=5m
CACHE_MODE=writes
CACHE_MAX_AGE=1h
CACHE_MAX_SIZE=10G
HUNK_SIZE_LIMIT=2048M
READ_CHUNK_SIZE=64M
BUFFER_SIZE=16M
EOF

cat ${CONFIGS}/Docker/components/??-* > ${CONFIGS}/Docker/docker-compose.yaml
echo done
