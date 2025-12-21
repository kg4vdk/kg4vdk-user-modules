#!/bin/bash

# MODULE NAME
MODULE_NAME="VSCODIUM"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${USER_MODULE_DIR}/${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

SAVE_DIR="${MODULE_DIR}/config"
mkdir -p "${SAVE_DIR}"/{"vscode-oss","VSCodium"}

unlink "$HOME/.vscode-oss"
rm -rf "$HOME/.vscode-oss"
ln -sTf "${SAVE_DIR}/vscode-oss" "$HOME/.vscode-oss"

unlink "$HOME/.config/VSCodium"
rm -rf "$HOME/.config/VSCodium"
ln -sTf "${SAVE_DIR}/VSCodium" "$HOME/.config/VSCodium"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"