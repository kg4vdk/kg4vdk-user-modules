#!/bin/bash

# MODULE NAME
MODULE_NAME="VERACRYPT"

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

killall veracrypt > /dev/null 2>&1

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p $SAVE_DIR

CONFIG_DIR="$HOME/.config/VeraCrypt"
FS_PATH="${SAVE_DIR}/veracrypt-fs"

if grep ".config/VeraCrypt" /etc/mtab; then
	sudo umount "${CONFIG_DIR}"
fi

rm -rf "${CONFIG_DIR}"
mkdir -p "${CONFIG_DIR}"

if [ ! -f "${FS_PATH}" ]; then
	dd if=/dev/zero of="${FS_PATH}" bs=1M count=16
	mkfs.ext4 "${FS_PATH}"
	sudo mount "${FS_PATH}" "${CONFIG_DIR}"
	sudo chown user:user "${CONFIG_DIR}"
	sudo chmod 700 "${CONFIG_DIR}"
	sudo umount "${CONFIG_DIR}"
fi

sudo mount "${FS_PATH}" "${CONFIG_DIR}"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
