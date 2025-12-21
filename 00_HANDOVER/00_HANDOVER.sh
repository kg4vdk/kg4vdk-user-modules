#!/bin/bash

# MODULE NAME
MODULE_NAME="HANDOVER"

# MODULE TYPE
MODULE_TYPE="USER"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# USER MODULE REPO
MY_MODULE_REPO="${MYCALL_LOWER}-user-modules"

# PATHS
ARCHIVE="/arcHIVE"
MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/${MODULE_TYPE}/${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

if [ -f "${MODULE_DIR}/ENABLED_MODULES" ]; then
    ENABLED_MODULES="$(cat ${MODULE_DIR}/ENABLED_MODULES)"
else
    ENABLED_MODULES=""
fi

if [ -n "${ENABLED_MODULES}" ]; then
    for i in $(echo "${ENABLED_MODULES}" | grep -v "_PRE_"); do
        MODULE_SCRIPT="$i"
        MODULE_SCRIPT_FULL="$(find "${USER_MODULE_DIR}/${MY_MODULE_REPO}" "$i")"
        if [ -f "${MODULE_SCRIPT_FULL}" ]; then
            echo -n "Running ${MODULE_SCRIPT}..."
            bash "${MODULE_SCRIPT_FULL}"
            echo "DONE!"
        else
            echo "${MODULE_SCRIPT} not found!"
        fi
    done
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"