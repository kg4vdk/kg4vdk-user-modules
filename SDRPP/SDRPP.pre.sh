#!/bin/bash

# MODULE NAME
MODULE_NAME="SDRPP"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.pre.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

killall sdrpp > /dev/null 2>&1

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p "${SAVE_DIR}"

if dpkg -s sdrpp > /dev/null 2>&1; then
	mkdir -p "${SAVE_DIR}/sdrpp"
	unlink "$HOME/.config/sdrpp"
	rm -rf "$HOME/.config/sdrpp"
	ln -sTf "${SAVE_DIR}/sdrpp" "$HOME/.config/sdrpp"
fi

sudo cp ${MODULE_DIR}/applications/sdrpp.desktop /usr/share/applications/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
