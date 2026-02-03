#!/bin/bash

# MODULE NAME
MODULE_NAME="SDRTRUNK"

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

pkill -fn sdr-trunk > /dev/null 2>&1

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p "${SAVE_DIR}"

sudo ln -sTf "${MODULE_DIR}/sdr-trunk-linux-x86_64/bin/sdr-trunk" /usr/local/bin/sdr-trunk

if which sdr-trunk > /dev/null 2>&1; then
	mkdir -p "${SAVE_DIR}/SDRTrunk"
	unlink "$HOME/SDRTrunk"
	rm -rf "$HOME/SDRTrunk"
	ln -sTf "${SAVE_DIR}/SDRTrunk" "$HOME/SDRTrunk"
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
