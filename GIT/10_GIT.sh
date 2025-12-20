#!/bin/bash

# MODULE NAME
MODULE_NAME="GIT"

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

cp "${MODULE_DIR}/config/ssh-config" "$HOME/.ssh/config"
cp "${MODULE_DIR}/keys/arcos-github-key" "$HOME/.ssh/"

chmod 600 "$HOME/.ssh/arcos-github-key"

git config --global user.email "mike@kg4vdk.com"
git config --global user.name "Mike Fisher"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"