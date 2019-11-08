#!/bin/bash

docker ps -q -f name=${APP} > ${CONFIGVARS}/checkapp
clear

if [ -s ${CONFIGVARS}/checkapp ]; then

	ALREADYINSTALLED

else

	EXPLAINAPP

	CONFIRMATION

	if [[ ${REPLY} =~ ^[Yy]$ ]]; then

		GOAHEAD

		echo ""
		echo "--------------------------------------------------"
		echo " Please choose what version you want to install:"
		echo ""
		[[ -f "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}.yaml" ]] && echo " ${LYELLOW}S${STD} - ${TASK} Stable"
		[[ -f "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}-beta.yaml" ]] && echo " ${LYELLOW}B${STD} - ${TASK} Beta"
		echo "--------------------------------------------------"
		echo ""
		read -n 1 -s -r -p " ---> "
		echo ""

		case "${REPLY}" in
			s|S ) APPLOC=${APPLOC} ;;
			b|B ) [[ -f "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}-beta.yaml" ]] && APPLOC=${APPLOC}-beta ;;
			* ) APPLOC=${APPLOC} ;;
		esac

		if [[ -d ${OLDLOC} && ! -d ${CONFIGS}/${TASK} ]]; then

			clear
			echo "${YELLOW}"
			echo "--------------------------------------------------"
			echo " It seems you installed ${TASK} previously"
			echo " Would you like to import those settings? (Y/n)"
			echo "--------------------------------------------------"
			echo "${STD}"
			read -n 1 -s -r -p " ---> "
			echo ""

			case "${REPLY}" in
				n|N ) echo "Settings not imported"; echo "You chose to start from scratch" ;;
				* ) echo "Great, importing settings"; sudo mv ${OLDLOC} ${CONFIGS}/${TASK} ;;
			esac

		fi

		if [[ ${TASK} = "Plex" && ! -d ${OLDLOC} && ! -d ${CONFIGS}/${TASK} ]]; then

			clear
			echo "${YELLOW}"
			echo "--------------------------------------------------"
			echo " It seems you are new to ${TASK}"
			echo " In order to proceed, you will need to visit"
			echo " https://www.${LYELLOW}plex.tv/claim${YELLOW}"
			echo " and copy the token to clipboard"
			echo ""
			echo " Make sure you activate the token within 4 minutes"
			echo " at ${LYELLOW}${APP}.${MYDOMAIN}:8443${YELLOW}"
			echo "--------------------------------------------------"
			echo "${STD}"
			read -e -p " Paste token here: " PLEXCLAIM
			echo ""
			echo "${PLEXCLAIM}" > ${CONFIGVARS}/plexclaim

		fi

		echo ""
		cd ${CONFIGS}/Docker
		sudo rsync -a /opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}.yaml ${CONFIGS}/Docker/components
		echo "Just a moment while ${APP} is being installed..."
		source /opt/Gooby/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans
		cd "${CURDIR}"

		if [ ${APP} == organizr ]; then APP=${ORGMENU}; fi

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm ${CONFIGVARS}/checkapp
PAUSE
