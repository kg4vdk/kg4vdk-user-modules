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
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p "${SAVE_DIR}"

# Define the feeder ID
if [ -f "${SAVE_DIR}/FEEDER_ID" ]; then
	FEEDER_ID="$(cat "${SAVE_DIR}/FEEDER_ID")"
else
	FEEDER_ID=""
fi

if [ "${FEEDER_ID}" != "" ]; then
	echo "${FEEDER_ID}" | sudo tee "/var/cache/piaware/feeder_id"
	sudo systemctl restart piaware.service
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
