# GMOD
echo 'Installing GMOD...'
${STEAMCMDDIR}/steamcmd.sh  +login anonymous \
                            +force_install_dir ${GMOD_DIR} \
                            +app_update ${GMOD_ID} \
                            +quit
echo 'Done'

# CSS
echo 'Installing CSS...'
${STEAMCMDDIR}/steamcmd.sh  +login anonymous \
                            +force_install_dir ${CSS_DIR} \
                            +app_update ${CSS_ID} \
                            +quit
echo 'Done'

# TF2
echo 'Installing TF2...'
${STEAMCMDDIR}/steamcmd.sh  +login anonymous \
                            +force_install_dir ${TF2_DIR} \
                            +app_update ${TF2_ID} \
                            +quit
echo 'Done'							

# GENERATE AUTOUPDATE SCRIPT
{ \
	echo '@ShutdownOnFailedCommand 1'; \
	echo '@NoPromptForPassword 1'; \
	echo 'login anonymous'; \
	echo 'force_install_dir ${GMOD_DIR}'; \
	echo 'app_update ${GMOD_DIR}'; \
	echo 'quit'; \
} > ${GMOD_DIR}/gmod_update.txt

# GENERATE MOUNT CONFIG
{ \
		echo '"mountcfg"'; \
		echo '{'; \
		echo '  "cstrike"    "${GMOD_DIR}/sharedcontent/cstrike"'; \
		echo '  "tf"         "${GMOD_DIR}/sharedcontent/tf"'; \
		echo '}'; \
} > ${GMOD_DIR}/garrysmod/cfg/mount.cfg

echo 'Starting GMOD Server...'
${GMOD_DIR}/srcds_run   -game garrysmod \
						-autoupdate \
						-steam_dir ${STEAMCMDDIR} \
						-steamcmd_script ${GMOD_DIR}/gmod_update.txt \
						-maxplayers ${MAX_PLAYERS} \
						-port ${PORT} \
						+gamemode ${GAMEMODE} \
						+map ${MAP} \
						+host_workshop_collection ${WORKSHOP_COLLECTION} \
					    -authkey ${WORKSHOP_COLLECTION_AUTH_KEY} 