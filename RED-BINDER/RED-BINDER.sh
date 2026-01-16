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

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p "${SAVE_DIR}"

BINDER_PATH="${SAVE_DIR}/red-binder"

if [ ! -d "${BINDER_PATH}" ]; then
    cp -r "${MODULE_DIR}/red-binder" "${BINDER_PATH}"
fi

ICONS_PATH="${MODULE_DIR}/icons"

COLOR_01="red"
COLOR_02="pink"
COLOR_03="orange"
COLOR_04="yellow"
COLOR_05="green"
COLOR_06="blue"
COLOR_07="indigo"
COLOR_08="violet"
COLOR_09="black"
COLOR_10="grey"

gio set "${BINDER_PATH}" metadata::custom-icon file://"${ICONS_PATH}"/folders/red-folder-star.png && touch "${BINDER_PATH}"
gio set "${BINDER_PATH}"/01* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_01}"-folder.png && touch "${BINDER_PATH}"/01*
gio set "${BINDER_PATH}"/02* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_02}"-folder.png && touch "${BINDER_PATH}"/02*
gio set "${BINDER_PATH}"/03* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_03}"-folder.png && touch "${BINDER_PATH}"/03*
gio set "${BINDER_PATH}"/04* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_04}"-folder.png && touch "${BINDER_PATH}"/04*
gio set "${BINDER_PATH}"/05* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_05}"-folder.png && touch "${BINDER_PATH}"/05*
gio set "${BINDER_PATH}"/06* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_06}"-folder.png && touch "${BINDER_PATH}"/06*
gio set "${BINDER_PATH}"/07* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_07}"-folder.png && touch "${BINDER_PATH}"/07*
gio set "${BINDER_PATH}"/08* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_08}"-folder.png && touch "${BINDER_PATH}"/08*
gio set "${BINDER_PATH}"/09* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_09}"-folder.png && touch "${BINDER_PATH}"/09*
gio set "${BINDER_PATH}"/10* metadata::custom-icon file://"${ICONS_PATH}"/folders/"${COLOR_10}"-folder.png && touch "${BINDER_PATH}"/10*

LINK_PATH="$HOME/Desktop/Red Binder"

unlink "${LINK_PATH}"
rm -rf "${LINK_PATH}"
ln -sTf "${BINDER_PATH}" "${LINK_PATH}"

gio set "${LINK_PATH}" metadata::custom-icon file://"${ICONS_PATH}"/folders/red-folder-star.png && touch "${LINK_PATH}"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
