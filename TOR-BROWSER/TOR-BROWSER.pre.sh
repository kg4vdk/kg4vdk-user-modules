#!/bin/bash

# MODULE NAME
MODULE_NAME="TOR-BROWSER"

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
mkdir -p "${SAVE_DIR}"

pkill -f firefox.real > /dev/null 2>&1

if [ -f ${SAVE_DIR}/tor-browser/start-tor-browser.desktop ]; then
	cd ${SAVE_DIR}/tor-browser
	${SAVE_DIR}/tor-browser/start-tor-browser.desktop --register-app
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

