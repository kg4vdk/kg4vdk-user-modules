#!/bin/bash

# MODULE NAME
MODULE_NAME="DOCKER"

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

sudo systemctl stop docker.service docker.socket containerd.service

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p $SAVE_DIR

CONFIG_DIR="/var/lib/docker"
FS_PATH="${SAVE_DIR}/docker-fs"

if grep "docker" /etc/mtab; then
	sudo umount "${CONFIG_DIR}"
fi

sudo rm -rf "${CONFIG_DIR}"
sudo mkdir -p "${CONFIG_DIR}"

if [ ! -f "${FS_PATH}" ]; then
	dd if=/dev/zero of="${FS_PATH}" bs=1M count=2048
	mkfs.ext4 "${FS_PATH}"
	sudo mount "${FS_PATH}" "${CONFIG_DIR}"
	sudo chown root:root "${CONFIG_DIR}"
	sudo chmod 740 "${CONFIG_DIR}"
	sudo umount "${CONFIG_DIR}"
fi

####

CONFIG_DIR2="/var/lib/containerd"
FS_PATH2="${SAVE_DIR}/containerd-fs"

if grep "containerd" /etc/mtab; then
	sudo umount "${CONFIG_DIR2}"
fi

sudo rm -rf "${CONFIG_DIR2}"
sudo mkdir -p "${CONFIG_DIR2}"

if [ ! -f "${FS_PATH2}" ]; then
	dd if=/dev/zero of="${FS_PATH2}" bs=1M count=4096
	mkfs.ext4 "${FS_PATH2}"
	sudo mount "${FS_PATH2}" "${CONFIG_DIR2}"
	sudo chown root:root "${CONFIG_DIR2}"
	sudo chmod 700 "${CONFIG_DIR2}"
	sudo umount "${CONFIG_DIR2}"
fi

####

sudo mount "${FS_PATH}" "${CONFIG_DIR}"
sudo mount "${FS_PATH2}" "${CONFIG_DIR2}"

####

sudo systemctl start docker.service docker.socket containerd.service

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
