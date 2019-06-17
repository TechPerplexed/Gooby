# Moving all Proxy folders to Docker

if [ -d $CONFIGS/Security ]; then
	sudo mv /$CONFIGS/Certs $CONFIGS/Docker
	sudo mv $CONFIGS/Docker/Certs $CONFIGS/Docker/certs
	sudo mv /$CONFIGS/nginx $CONFIGS/Docker
	sudo mv /$CONFIGS/Security $CONFIGS/Docker	
	sudo mv $CONFIGS/Docker/Security $CONFIGS/Docker/security
fi
