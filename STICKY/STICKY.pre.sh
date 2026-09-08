#!/bin/bash

# MODULE NAME
MODULE_NAME="STICKY"

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

killall sticky.py > /dev/null 2>&1

sudo cp ${MODULE_DIR}/conf/sticky.css /usr/share/sticky/sticky.css
sudo cp ${MODULE_DIR}/conf/sticky.py /usr/lib/sticky/sticky.py

#gsettings set org.x.sticky autostart-notes-visible true

sticky --autostart &

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
