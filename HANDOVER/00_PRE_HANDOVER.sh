#!/bin/bash

# MODULE NAME
MODULE_NAME="HANDOVER"

# MODULE TYPE
MODULE_TYPE="USER"

# STATION INFO
source "$HOME/.station-info"

# PATHS
ARCHIVE="/arcHIVE"
MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/${MODULE_TYPE}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/PRE_${MODULE_NAME}.log"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

MY_MODULE_REPO="kg4vdk-user-modules"

for i in $(ls "${USER_MODULE_DIR}/${MY_MODULE_REPO}/*_PRE_*.sh"); do
    MODULE_NAME=$(basename $i)
    echo "${MODULE_NAME}"
    bash $i
done

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"