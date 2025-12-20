#!/bin/bash

# MODULE NAME
MODULE_NAME="TRANSMISSION"

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

SAVE_DIR="${MODULE_DIR}/config"
mkdir -p "${SAVE_DIR}/transmission"

unlink "$HOME/.config/transmission"
rm -rf "$HOME/.config/transmission"
ln -sTf "${SAVE_DIR}/transmission" "$HOME/.config/transmission"

if ! pidof transmission-gtk; then
	transmission-gtk --minimized &
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"