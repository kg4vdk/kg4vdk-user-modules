#!/bin/bash

# MODULE NAME
MODULE_NAME="PUBLII"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.pre.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

if [ -f $ARCHIVE/QRV/$MYCALL/SAVED/$MODULE_NAME/publii.AppImage ]; then
	mkdir -p $ARCHIVE/QRV/$MYCALL/SAVED/$MODULE_NAME/publii.AppImage.home
fi
cp ${MODULE_DIR}/icons/Publii.png $HOME/.local/share/icons/
cp ${MODULE_DIR}/applications/publii.desktop $HOME/.local/share/applications/
sed -i "s:^Exec=.*$:Exec=$ARCHIVE/QRV/$MYCALL/SAVED/$MODULE_NAME/publii.AppImage:" $HOME/.local/share/applications/publii.desktop

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
