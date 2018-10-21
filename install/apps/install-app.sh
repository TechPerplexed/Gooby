#!/bin/bash

docker ps -q -f name=$APP > $CONFIGS/.config/checkapp.txt
clear

if [ -s $CONFIGS/.config/checkapp.txt ]; then

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
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC.yaml" ]] && echo " ${LYELLOW}S${STD} - ${WHITE}$TASK Stable${STD} (recommended)"
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC-beta.yaml" ]] && echo " ${YELLOW}B${STD} - $TASK Beta"
		[[ -f "/opt/GooPlex/scripts/components/$APPLOC-cf.yaml" ]] && echo " ${YELLOW}C${STD} - $TASK Stable with CloudFlare"
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

		if [[ -d $OLDLOC && ! -d $CONFIGS/$TASK ]]; then

			echo "${YELLOW}"
			echo "--------------------------------------------------"
			echo " It seems you installed $TASK previously"
			echo " Would you like to import those settings? (Y/n)"
			echo "--------------------------------------------------"
			echo "${STD}"
			read -n 1 -s -r -p " ---> "
			echo ""

			case "$REPLY" in
				n|N ) echo "Settings not imported"; echo "You chose to start from scratch" ;;
				* ) echo "Great, importing settings"; sudo mv $OLDLOC $CONFIGS/$TASK ;;
			esac

		fi



		fi

		echo ""
		cd $CONFIGS/Docker
		sudo rsync -a /opt/GooPlex/scripts/components/$APPLOC.yaml $CONFIGS/Docker/components
		/usr/local/bin/docker-compose down
		echo "Just a moment while $APP is being installed..."
		source /opt/GooPlex/install/misc/environment-build.sh rebuild
		/usr/local/bin/docker-compose up -d --remove-orphans ${@:2}
		sudo chown -R $USER:$USER $CONFIGS
		cd "${CURDIR}"
		
		if [ $APP == organizr ]; then APP=$ORGMENU; fi

		APPINSTALLED

		TASKCOMPLETE

	else

		CANCELTHIS

	fi

fi

rm $CONFIGS/.config/checkapp.txt
PAUSE
