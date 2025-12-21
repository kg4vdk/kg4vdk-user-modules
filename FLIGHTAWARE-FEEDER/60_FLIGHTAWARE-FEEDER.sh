#!/bin/bash

# MODULE NAME
MODULE_NAME="FLIGHTAWARE-FEEDER"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${USER_MODULE_DIR}/${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Define the feeder ID
if [ -f "${MODULE_DIR}/feeder_id" ]; then
	FEEDER_ID="$(cat "${MODULE_DIR}/feeder_id")"
else
	FEEDER_ID=""
fi

if [ "${FEEDER_ID}" != "" ]; then
	echo "${FEEDER_ID}" | sudo tee "/var/cache/piaware/feeder_id"
	sudo systemctl restart piaware.service
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"
