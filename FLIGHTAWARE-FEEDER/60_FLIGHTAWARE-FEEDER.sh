#!/bin/bash

# MODULE NAME
MODULE_NAME="FLIGHTAWARE-FEEDER"

# MODULE TYPE
MODULE_TYPE="USER"

# STATION INFO
source "$HOME/.station-info"

# PATHS
ARCHIVE="/arcHIVE"
MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/${MODULE_TYPE}/${MODULE_NAME}"
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
