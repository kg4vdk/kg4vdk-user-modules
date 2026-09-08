#!/bin/bash

# MODULE NAME
MODULE_NAME="SYSTEMD"

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

mkdir -p $HOME/.config/systemd/user

if [ -d "${ARCHIVE}/QRV/${MYCALL}/.systemd/user" ]; then
	rm -rf "$HOME/.config/systemd/user"
	cp -a "${ARCHIVE}/QRV/${MYCALL}/.systemd/user" "$HOME/.config/systemd/user"
fi

for SERVICE in $HOME/.config/systemd/user/*.service; do
	systemctl --user enable $SERVICE
done

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
