#!/bin/bash

# MODULE NAME
MODULE_NAME="MINETEST"

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

killall minetest > /dev/null 2>&1

if dpkg -s minetest > /dev/null 2>&1; then
	mkdir -p "${MODULE_DIR}/minetest"
	unlink "$HOME/.minetest"
	rm -rf "$HOME/.minetest"
	ln -sTf "${MODULE_DIR}/minetest" "$HOME/.minetest"
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"