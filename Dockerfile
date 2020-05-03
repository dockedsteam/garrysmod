# SteamCMD Base-Image
FROM cm2network/steamcmd:root

LABEL maintainer="dockedsteam@raphaelgosteli.com"

# ENV

## Garry's Mod
ENV GMOD_ID=4020
ENV GMOD_DIR=/home/steam/gmod
ENV GMOD_SHAREDCONTENT_DIR=${GMOD_DIR}/sharedcontent

ENV PORT=27015
ENV MAX_PLAYERS=16
ENV MAP=gm_flatgrass
ENV GAMEMODE=sandbox
ENV WORKSHOP_COLLECTION=
ENV WORKSHOP_COLLECTION_AUTH_KEY=

## Counter-Strike: Source 
ENV CSS_ID=232330
ENV CSS_DIR=${GMOD_SHAREDCONTENT_DIR}

## Team Fortress 2
ENV TF2_ID=232250
ENV TF2_DIR=${GMOD_SHAREDCONTENT_DIR}

# SETUP
WORKDIR ${GMOD_DIR}
RUN apt-get update
RUN apt-get install -y --no-install-recommends --no-install-suggests \
	wget=1.20.1-1.1 
RUN wget https://raw.githubusercontent.com/dockedsteam/garrysmod/master/entrypoint.sh
RUN chmod 755 ${GMOD_DIR}/entrypoint.sh
RUN chown -R steam:steam ${GMOD_DIR}
USER steam

ENTRYPOINT /bin/bash ${GMOD_DIR}/entrypoint.sh

EXPOSE ${PORT}/udp