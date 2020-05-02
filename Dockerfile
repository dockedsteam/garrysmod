# SteamCMD Base-Image
FROM cm2network/steamcmd:root

LABEL maintainer="raphael.gosteli@gmail.com"

# ENV

## Garry's Mod
ENV GMOD_ID 4020
ENV GMOD_DIR /home/steam/gmod
ENV GMOD_SHAREDCONTENT_DIR=${GMOD_DIR}/sharedcontent

ENV MAX_PLAYERS=16
ENV MAP=gm_flatgrass
ENV GAMEMODE=sandbox
ENV WORKSHOP_COLLECTION=
ENV WORKSHOP_COLLECTION_AUTH_KEY=
ENV PASSWORD=
ENV RCON_PASSWORD=

## Counter-Strike: Source 
ENV CSS_ID=232330
ENV CSS_DIR=${GMOD_SHAREDCONTENT_DIR}

## Team Fortress 2
ENV TF2_ID=232250
ENV TF2_DIR=${GMOD_SHAREDCONTENT_DIR}

# SETUP
USER steam
WORKDIR ${GMOD_DIR}

## INSTALLATION
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${GMOD_DIR} +app_update ${GMOD_ID} validate +quit
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${CSS_DIR} +app_update ${CSS_ID} validate +quit
RUN ${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${TF2_DIR} +app_update ${TF2_DIR} validate +quit

## GENERATE AUTOUPDATE SCRIPT
RUN { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir ${STEAMAPPDIR}'; \
		echo 'app_update ${STEAMAPPID} validate'; \
		echo 'quit'; \
} > ${GMOD_DIR}/gmod_update.txt

## GENERATE MOUNT CONFIG
RUN { \
		echo '"mountcfg"'; \
		echo '{'; \
		echo '  "cstrike"    "${CSS_STEAMAPPDIR}/sharedcontent/cstrike"'; \
		echo '  "tf"         "${CSS_STEAMAPPDIR}/sharedcontent/tf"'; \
		echo '}'; \
} > ${STEAMAPPDIR}/garrysmod/cfg/mount.cfg


# RUN CONFUGURATION
ENTRYPOINT ${GMOD_DIR}/srcds_run 	-game garrysmod \
								 	-autoupdate \
									-steam_dir ${STEAMCMDDIR} \
									-steamcmd_script ${GMOD_DIR}}/gmod_update.txt \
									-maxplayers ${MAX_PLAYERS} \
									+gamemode ${GAMEMODE} \
									+map ${MAP} \
									+host_workshop_collection ${WORKSHOP_COLLECTION} \
									-authkey ${WORKSHOP_COLLECTION_AUTH_KEY} 

EXPOSE 27015/udp