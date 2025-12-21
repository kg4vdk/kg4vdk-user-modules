#!/bin/bash

# MODULE NAME
MODULE_NAME="TRANSMISSION"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p "${SAVE_DIR}/config/transmission"/{"resume","torrents"}

if [ ! -f "${SAVE_DIR}/config/transmission/settings.json" ]; then
	cp "${MODULE_DIR}/config/transmission/settings.json" "${SAVE_DIR}/config/transmission/settings.json"
fi

if [ ! -f "${SAVE_DIR}/config/transmission/torrents/8242f84b2f8c6fabddc639a485d77f66ac702d50.torrent" ]; then
	cp -R "${MODULE_DIR}/config/transmission/torrents" "${SAVE_DIR}/config/transmission/"
fi

if [ ! -f "${SAVE_DIR}/config/transmission/resume/8242f84b2f8c6fabddc639a485d77f66ac702d50" ]; then
	cp -R "${MODULE_DIR}/config/transmission/resume" "${SAVE_DIR}/config/transmission/"
fi

unlink "$HOME/.config/transmission"
rm -rf "$HOME/.config/transmission"
ln -sTf "${SAVE_DIR}/config/transmission" "$HOME/.config/transmission"

if ! pidof transmission-gtk; then
	transmission-gtk --minimized &
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"