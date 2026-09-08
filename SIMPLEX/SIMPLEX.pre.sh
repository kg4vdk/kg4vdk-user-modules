#!/bin/bash

######################
# SIMPLEX QRV MODULE #
######################
MODULE_NAME="SIMPLEX"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.pre.log"

### MODULE COMMANDS FUNCTION ###
module_commands () {

kill -9 $(pidof simplex.AppImage) > /dev/null 2>&1

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p $SAVE_DIR

if [ -f $HOME/.local/share/applications/simplex.desktop ]; then
	rm $HOME/.local/share/applications/simplex.desktop
fi

CONFIG_DIR="$HOME/.config/simplex"
SHARE_DIR="$HOME/.local/share/simplex"
FS_PATH="${SAVE_DIR}/simplex-fs"

if grep "simplex" /etc/mtab; then
	sudo umount "${CONFIG_DIR}"
	sudo umount "${SHARE_DIR}"
fi

rm -rf "${CONFIG_DIR}"
mkdir -p "${CONFIG_DIR}"

rm -rf "${SHARE_DIR}"
mkdir -p "${SHARE_DIR}"

if [ ! -f "${FS_PATH}" ]; then
	dd if=/dev/zero of="${FS_PATH}" bs=1M count=512
	mkfs.ext4 "${FS_PATH}"
	sudo mount "${FS_PATH}" "${CONFIG_DIR}"
	sudo chown user:user "${CONFIG_DIR}"
	sudo chmod 700 "${CONFIG_DIR}"
	sudo umount "${CONFIG_DIR}"
fi

sudo mount "${FS_PATH}" "${CONFIG_DIR}"
sudo mount "${FS_PATH}" "${SHARE_DIR}"

cp ${MODULE_DIR}/applications/simplex.desktop $HOME/.local/share/applications/

sed -i "s:^Exec=.*$:Exec=${SAVE_DIR}/simplex.AppImage:" $HOME/.local/share/applications/simplex.desktop

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
