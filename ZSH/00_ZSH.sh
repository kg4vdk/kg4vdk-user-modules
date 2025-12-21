#!/bin/bash

# MODULE NAME
MODULE_NAME="TNSPARC"

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