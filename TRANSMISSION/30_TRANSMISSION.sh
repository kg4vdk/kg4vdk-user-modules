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
mkdir -p "${SAVE_DIR}/transmission"/{"resume","torrents"}

if [ ! -f "${SAVE_DIR}/transmission/settings.json" ]; then
	cp "${MODULE_DIR}/config/settings.json" "${SAVE_DIR}/transmission/settings.json"
fi

if [ ! -f "${SAVE_DIR}/transmission/torrents/8242f84b2f8c6fabddc639a485d77f66ac702d50.torrent" ]; then
	cp -R "${MODULE_DIR}/config/torrents" "${SAVE_DIR}/transmission/torrents/"
fi

if [ ! -f "${SAVE_DIR}/transmission/resume/8242f84b2f8c6fabddc639a485d77f66ac702d50" ]; then
	cp -R "${MODULE_DIR}/config/resume" "${SAVE_DIR}/transmission/resume"
fi

unlink "$HOME/.config/transmission"
rm -rf "$HOME/.config/transmission"
ln -sTf "${SAVE_DIR}/transmission" "$HOME/.config/transmission"

if ! pidof transmission-gtk; then
	transmission-gtk --minimized &
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"