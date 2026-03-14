#!/bin/bash

# MODULE NAME
MODULE_NAME="GIT"

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

if [ -f $SAVE_DIR/gitconfig ]; then
	rm $HOME/.gitconfig
	ln -sf $SAVE_DIR/gitconfig $HOME/.gitconfig
else
	touch $SAVE_DIR/gitconfig
	rm $HOME/.gitconfig
	ln -sf $SAVE_DIR/gitconfig $HOME/.gitconfig
	git config --global user.email "${MYCALL_LOWER}@arcOS.local"
	git config --global user.name "${MYCALL}"
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
