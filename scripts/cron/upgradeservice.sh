#!/bin/bash

VERSION=2.2.2

CONFIGVARS=${CONFIGS}/Docker/.config
sudo mkdir -p ${CONFIGVARS}
sudo chown -R ${USER}:${USER} ${CONFIGS}/Docker
touch ${CONFIGVARS}/version

if [ "$(cat ${CONFIGVARS}/version)" == ${VERSION} ]; then

	echo "${GREEN}Your system has already been upgraded to v${VERSION}... skipping upgrade${STD}"; echo

else

	echo "${LYELLOW}Upgrading to v${VERSION}... just a moment${STD}"; echo; sleep 2

	# Update and rename apps

	[[ -f ${CONFIGS}/Docker/components/00-version.yaml ]] && sudo mv ${CONFIGS}/Docker/components/00-version.yaml ${CONFIGS}/Docker/components/01-header.yaml
	[[ -f ${CONFIGS}/Docker/components/01-proxy.yaml ]] && sudo mv ${CONFIGS}/Docker/components/01-proxy.yaml ${CONFIGS}/Docker/components/03-proxy.yaml
	[[ -f ${CONFIGS}/Docker/components/02-netdata.yaml ]] && sudo mv ${CONFIGS}/Docker/components/02-netdata.yaml ${CONFIGS}/Docker/components/62-netdata.yaml
	[[ -f ${CONFIGS}/Docker/components/03-organizr-beta.yaml ]] && sudo mv ${CONFIGS}/Docker/components/03-organizr-beta.yaml ${CONFIGS}/Docker/components/11-organizr-beta.yaml
	[[ -f ${CONFIGS}/Docker/components/03-organizr.yaml ]] && sudo mv ${CONFIGS}/Docker/components/03-organizr.yaml ${CONFIGS}/Docker/components/11-organizr.yaml
	[[ -f ${CONFIGS}/Docker/components/98-watchtower.yaml ]] && sudo mv ${CONFIGS}/Docker/components/98-watchtower.yaml ${CONFIGS}/Docker/components/04-watchtower.yaml
	[[ -f ${CONFIGS}/Docker/components/10-portainer.yaml ]] && sudo mv ${CONFIGS}/Docker/components/10-portainer.yaml ${CONFIGS}/Docker/components/64-portainer.yaml
	[[ -f ${CONFIGS}/Docker/components/20-plex-beta.yaml ]] && sudo mv ${CONFIGS}/Docker/components/20-plex-beta.yaml ${CONFIGS}/Docker/components/21-plex-beta.yaml
	[[ -f ${CONFIGS}/Docker/components/20-plex-hw.yaml ]] && sudo mv ${CONFIGS}/Docker/components/20-plex-hw.yaml ${CONFIGS}/Docker/components/21-plex-hw.yaml
	[[ -f ${CONFIGS}/Docker/components/20-plex.yaml ]] && sudo mv ${CONFIGS}/Docker/components/20-plex.yaml ${CONFIGS}/Docker/components/21-plex.yaml
	[[ -f ${CONFIGS}/Docker/components/24-jellyfin.yaml ]] && sudo mv ${CONFIGS}/Docker/components/24-jellyfin.yaml ${CONFIGS}/Docker/components/23-jellyfin.yaml
	[[ -f ${CONFIGS}/Docker/components/30-nzbget.yaml ]] && sudo mv ${CONFIGS}/Docker/components/30-nzbget.yaml ${CONFIGS}/Docker/components/31-nzbget.yaml
	[[ -f ${CONFIGS}/Docker/components/33-sabnzbd.yaml ]] && sudo mv ${CONFIGS}/Docker/components/33-sabnzbd.yaml ${CONFIGS}/Docker/components/32-sabnzbd.yaml
	[[ -f ${CONFIGS}/Docker/components/40-deluge.yaml ]] && sudo mv ${CONFIGS}/Docker/components/40-deluge.yaml ${CONFIGS}/Docker/components/41-deluge.yaml
	[[ -f ${CONFIGS}/Docker/components/41-rtorrent.yaml ]] && sudo mv ${CONFIGS}/Docker/components/41-rtorrent.yaml ${CONFIGS}/Docker/components/45-rtorrent.yaml
	[[ -f ${CONFIGS}/Docker/components/44-jackett.yaml ]] && sudo mv ${CONFIGS}/Docker/components/44-jackett.yaml ${CONFIGS}/Docker/components/56-jackett.yaml
	[[ -f ${CONFIGS}/Docker/components/50-radarr-beta.yaml ]] && sudo mv ${CONFIGS}/Docker/components/50-radarr-beta.yaml ${CONFIGS}/Docker/components/51-radarr-beta.yaml
	[[ -f ${CONFIGS}/Docker/components/50-radarr.yaml ]] && sudo mv ${CONFIGS}/Docker/components/50-radarr.yaml ${CONFIGS}/Docker/components/51-radarr.yaml
	[[ -f ${CONFIGS}/Docker/components/51-radarr4k-beta.yaml ]] && sudo mv ${CONFIGS}/Docker/components/51-radarr4k-beta.yaml ${CONFIGS}/Docker/components/59-radarr4k-beta.yaml
	[[ -f ${CONFIGS}/Docker/components/51-radarr4k.yaml ]] && sudo mv ${CONFIGS}/Docker/components/51-radarr4k.yaml ${CONFIGS}/Docker/components/59-radarr4k.yaml
	[[ -f ${CONFIGS}/Docker/components/54-lidarr.yaml ]] && sudo mv ${CONFIGS}/Docker/components/54-lidarr.yaml ${CONFIGS}/Docker/components/53-lidarr.yaml
	[[ -f ${CONFIGS}/Docker/components/60-ombi.yaml ]] && sudo mv ${CONFIGS}/Docker/components/60-ombi.yaml ${CONFIGS}/Docker/components/12-ombi.yaml
	[[ -f ${CONFIGS}/Docker/components/65-monitorr.yaml ]] && sudo mv ${CONFIGS}/Docker/components/65-monitorr.yaml ${CONFIGS}/Docker/components/13-monitorr.yaml
	[[ -f ${CONFIGS}/Docker/components/80-php.yaml ]] && sudo mv ${CONFIGS}/Docker/components/80-php.yaml ${CONFIGS}/Docker/components/81-phpapache.yaml
	[[ -f ${CONFIGS}/Docker/components/91-postgres.yaml ]] && sudo mv ${CONFIGS}/Docker/components/91-postgres.yaml ${CONFIGS}/Docker/components/73-postgres.yaml
	[[ -f ${CONFIGS}/Docker/components/99-network.yaml ]] && sudo mv ${CONFIGS}/Docker/components/99-network.yaml ${CONFIGS}/Docker/components/99-footer.yaml

	[[ ! -f ${CONFIGS}/Docker/components/02-oauth.yaml ]] && sudo rsync -a /opt/Gooby/scripts/${PROXYVERSION}/{01-header.yaml,02-oauth.yaml,03-proxy.yaml,04-watchtower.yaml,05-autoheal.yaml,99-footer.yaml} ${CONFIGS}/Docker/components

	# Finalizing upgrade

	echo; echo "${GREEN}Upgrade to v${VERSION} complete... proceeding${STD}"; echo

fi

echo ${VERSION} > ${CONFIGVARS}/version
