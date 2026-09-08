#!/bin/bash

# MODULE NAME
MODULE_NAME="QRV-PROFILE"

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

source $HOME/.station-info

if [ "${QRV_PROFILE}" == "DEFAULT" ]; then
	#gtk-launch xyz.desktop > /dev/null 2>&1
fi

if [ "${QRV_PROFILE}" == "BOAT" ]; then
	gtk-launch viking.desktop > /dev/null 2>&1
fi

if [ "${QRV_PROFILE}" == "MOBILE" ]; then
	gtk-launch yaac.desktop > /dev/null 2>&1
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
