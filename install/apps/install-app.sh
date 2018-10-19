#!/bin/bash

docker ps -q -f name=$APP > $CONFIGS/.config/checkapp.txt
clear

if [ -s /tmp/checkapp.txt ]; then

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
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC.yaml" ]] && echo " ${YELLOW}S${STD} - $TASK Stable - default"
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC-beta.yaml" ]] && echo " ${YELLOW}B${STD} - $TASK Beta"
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC-cf.yaml" ]] && echo " ${YELLOW}C${STD}- $TASK Stable with CloudFlare"
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC-beta-cf.yaml" ]] && echo " ${YELLOW}Q${STD} - $TASK Beta with CloudFlare"
		echo "--------------------------------------------------"
		echo ""
		echo " (When in doubt, choose Stable or just hit Enter)"
		read -n 1 -s -r -p " ---> "
		echo ""
		
		case "$REPLY" in
			s|S ) APPLOC=$APPLOC ;;
			b|B ) [[ -f "/opt/GooPlex/scripts/components/$APPLOC-beta.yaml" ]] && APPLOC=$APPLOC-beta ;;
			c|C ) [[ -f "/opt/GooPlex/scripts/components/$APPLOC-cf.yaml" ]] && APPLOC=$APPLOC-cf ;;
			q|Q ) [[ -f "/opt/GooPlex/scripts/components/$APPLOC-beta-cf.yaml" ]] && APPLOC=$APPLOC-beta-cf ;;
			* ) APPLOC=$APPLOC ;;
		esac

		cd $CONFIGS/Docker
		sudo rsync -a /opt/GooPlex/scripts/components/$APPLOC.yaml $CONFIGS/Docker/components
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being installed..."
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		[[ -f "$CONFIGS/$TASK" ]] && sudo chown -R $USER:$USER $CONFIGS/$TASK		
		cd "${CURDIR}"

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
