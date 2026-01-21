#!/bin/bash

# MODULE NAME
MODULE_NAME="MINETEST"

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

killall minetest > /dev/null 2>&1

if dpkg -s minetest > /dev/null 2>&1; then
	mkdir -p "${MODULE_DIR}/minetest"
	unlink "$HOME/.minetest"
	rm -rf "$HOME/.minetest"
	ln -sTf "${MODULE_DIR}/minetest" "$HOME/.minetest"
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log