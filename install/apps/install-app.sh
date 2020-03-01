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
        [[ -d "/dev/dri" "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}-hwdecode.yaml" ]] && echo " ${LYELLOW}S${STD} - ${TASK} Hardware decode"
		echo "--------------------------------------------------"
		echo ""
		read -n 1 -s -r -p " ---> "
		echo ""

		case "${REPLY}" in
			s|S ) APPLOC=${APPLOC} ;;
			b|B ) [[ -f "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}-beta.yaml" ]] && APPLOC=${APPLOC}-beta ;;
			h|H ) [[ [[ -d "/dev/dri" "/opt/Gooby/scripts/${PROXYVERSION}/${APPLOC}-hwdecode.yaml" ]] && APPLOC=${APPLOC}-hwdecode ;;
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

        if [[ ${TASK} = "Plex" && -d "/dev/dri"  && ! -d ${CONFIGS}/${TASK} ]]; then
			clear
			echo "${YELLOW}"
			echo "--------------------------------------------------"
			echo " Plex use the Hardware transcode over iGPU starting "
			echo " Please wait Plex Docker will be patched"
			echo "--------------------------------------------------"
			echo ""
			intel="$(lspci | grep VGA | cut -d ":" -f3 | awk '{print $1}' | grep Intel)"
			if [[ "$intel" == "Intel" ]]; then apt-get install intel-gpu-tools -yqq; fi
			chmod -R 777 /dev/dri
			docker exec plex apt-get -yqq update
			docker exec plex apt-get -yqq install i965-va-driver vainfo
			docker restart plex
			GPU=$(lspci | grep VGA | cut -d ":" -f3)
			RAM=$(cardid=$(lspci | grep VGA |cut -d " " -f1);lspci -v -s $cardid | grep " prefetchable"| cut -d "=" -f2)
			echo "${GREEN}"
			echo "--------------------------------------------------"
			echo " Plex Docker patch for Hardware transcode over iGPU finished "
			echo "--------------------------------------------------"
			echo " Used " $GPU "and "$RAM "RAM"
			echo "--------------------------------------------------"
			echo ""

		fi

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm ${CONFIGVARS}/checkapp
PAUSE
