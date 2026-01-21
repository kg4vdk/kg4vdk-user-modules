#!/bin/bash

# MODULE NAME
MODULE_NAME="HANDOVER"

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

if [ -f "${MY_MODULE_REPO}/ENABLED_MODULES" ]; then
    ENABLED_MODULES="$(cat ${MY_MODULE_REPO}/ENABLED_MODULES)"
else
    ENABLED_MODULES=""
fi

if [ -n "${ENABLED_MODULES}" ]; then
    for i in $(echo "${ENABLED_MODULES}" | grep -v "^#" | grep -v "^[[:blank:]].*$" | grep -v "\.pre\.sh"); do
        MODULE_SCRIPT="$i"
        MODULE_SCRIPT_FULL="$(find "${MY_MODULE_REPO}" -name "$i")"
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
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log