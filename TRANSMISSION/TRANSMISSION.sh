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
mkdir -p "${SAVE_DIR}/config/transmission"

if [ ! -f "${SAVE_DIR}/config/transmission/settings.json" ]; then
	cp "${MODULE_DIR}/config/transmission/settings.json" "${SAVE_DIR}/config/transmission/settings.json"
fi

unlink "$HOME/.config/transmission"
rm -rf "$HOME/.config/transmission"
ln -sTf "${SAVE_DIR}/config/transmission" "$HOME/.config/transmission"

if ! pidof transmission-gtk; then
	transmission-gtk &
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
