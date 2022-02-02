#!/bin/bash

source /opt/Gooby/menus/variables.sh

ENV=${CONFIGS}/Docker/.env
touch ${ENV}

# Since Docker processes " as part of the paths, we don't actually store it in the variables.  However, BASH does require
#	the " if the string is going to have odd characters.  As a result, we have to load the existing environment line
#	by line and insert the " around the values.

# Load existing variables and use them as defaults, if available

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

# Config variables
CONFIGS=/var/local/Gooby
CONFIGVARS=${CONFIGS}/Docker/.config

# Server settings
MYDOMAIN=$(cat ${CONFIGVARS}/mydomain) 
MYEMAIL=$(cat ${CONFIGVARS}/myemail)
IP=$(curl ifconfig.me)
SERVER=$(hostname)
TIMEZONE=$(cat /etc/timezone)

# User settings
GROUPID=$(id -g)
GROUPNAME=${USER}
USERID=$(id -u)
USERNAME=${USER}

# App settings
CF_EMAIL=$(cat ${CONFIGVARS}/cf_email)
CF_KEY=$(cat ${CONFIGVARS}/cf_key)
GPUGIDS=$(getent group video | cut -d: -f3)
PLEXCLAIM=$(cat ${CONFIGVARS}/plexclaim)

# Gooby settings
APILOG=${LOGS}/api.log
CURDIR=$(pwd)
GOOBYBRANCH=$(cat ${CONFIGVARS}/goobybranch)
LOGS=${HOME}/logs
PROXYVERSION=$(cat ${CONFIGVARS}/proxyversion)
VERSION=$(cat ${CONFIGVARS}/version)

# Rclone settings
RCLONEHOME=${HOMEDIR}/.config/rclone
RCLONESERVICE=$(cat ${CONFIGVARS}/rcloneservice)
RCLONEFOLDER=$(cat ${CONFIGVARS}/rclonefolder)
RCLONEUSERNAME=$(cat ${CONFIGVARS}/rcloneusername)
RCLONEPASSWORD=$(cat ${CONFIGVARS}/rclonepassword)

# Mounts and locations
HOMEDIR=${HOME}
LOCALFILES=$(cat ${CONFIGVARS}/localfiles)
MEDIA=$(cat ${CONFIGVARS}/media)
RCLONEMOUNT=$(cat ${CONFIGVARS}/rclonemount)
ROOTMOUNT=$(cat ${CONFIGVARS}/rootmount)
UPLOADS=$(cat ${CONFIGVARS}/uploads)
DOWNLOADS=${HOMEDIR}/Downloads

# Legacy variables
GOOGLE=$(cat ${CONFIGVARS}/media)

EOF

cat ${CONFIGS}/Docker/components/??-* > ${CONFIGS}/Docker/docker-compose.yaml
echo done
