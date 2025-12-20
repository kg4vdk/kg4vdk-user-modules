#!/bin/bash

# MODULE NAME
MODULE_NAME="TNSPARC"

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

SAVE_DIR="${MODULE_DIR}/SAVED"
QRV_PROFILE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/PROFILES"

mkdir -p "${SAVE_DIR}"
if [ ! -f "${SAVE_DIR}/zsh_history" ]; then
	touch "${SAVE_DIR}/zsh_history"
fi

rm -rf "$HOME/{.zshrc,.zsh_history,.oh-my-zsh,.p10k.zsh}"

cp "${MODULE_DIR}/config/zshrc" "$HOME/.zshrc"
ln -sTf "${SAVE_DIR}/zsh_history" "$HOME/.zsh_history"
cp "${MODULE_DIR}/config/p10k.zsh" "$HOME/.p10k.zsh"
tar -C "$HOME" -xaf "${MODULE_DIR}/config/oh-my-zsh.tar.gz"

if ! tail -n 1 "$HOME/.bashrc" | grep "zsh"; then
	echo -e "\n\n# Default to zsh\nzsh" >> "$HOME/.bashrc"
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > "${LOGFILE}" 2>&1 || notify-send --icon=error "${MODULE_NAME}" "${MODULE_NAME} module failed!"