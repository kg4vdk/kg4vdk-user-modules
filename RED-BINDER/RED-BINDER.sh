#!/bin/bash

# MODULE NAME
MODULE_NAME="RED-BINDER"

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

BINDER_PATH="$HOME/Desktop/Red Binder"
ICONS_PATH="${MODULE_DIR}/icons"

rm -rf "${BINDER_PATH}"
cp -r ${MODULE_DIR}/binder "${BINDER_PATH}"

gio set "${BINDER_PATH}" metadata::custom-icon file://"${ICONS_PATH}"/folders/red-folder-star.png && touch "${BINDER_PATH}"

gio set "${BINDER_PATH}"/01* metadata::custom-icon file://"${ICONS_PATH}"/folders/yellow-folder.png && touch "${BINDER_PATH}"/01*
gio set "${BINDER_PATH}"/02* metadata::custom-icon file://"${ICONS_PATH}"/folders/orange-folder.png && touch "${BINDER_PATH}"/02*
gio set "${BINDER_PATH}"/03* metadata::custom-icon file://"${ICONS_PATH}"/folders/red-folder.png && touch "${BINDER_PATH}"/03*
gio set "${BINDER_PATH}"/04* metadata::custom-icon file://"${ICONS_PATH}"/folders/pink-folder.png && touch "${BINDER_PATH}"/04*
gio set "${BINDER_PATH}"/05* metadata::custom-icon file://"${ICONS_PATH}"/folders/violet-folder.png && touch "${BINDER_PATH}"/05*
gio set "${BINDER_PATH}"/06* metadata::custom-icon file://"${ICONS_PATH}"/folders/indigo-folder.png && touch "${BINDER_PATH}"/06*
gio set "${BINDER_PATH}"/07* metadata::custom-icon file://"${ICONS_PATH}"/folders/blue-folder.png && touch "${BINDER_PATH}"/07*
gio set "${BINDER_PATH}"/08* metadata::custom-icon file://"${ICONS_PATH}"/folders/green-folder.png && touch "${BINDER_PATH}"/08*

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
