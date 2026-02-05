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
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

### MODULE COMMANDS FUNCTION ###
module_commands () {

kill -9 $(pidof simplex.AppImage) > /dev/null 2>&1

SAVE_DIR="${ARCHIVE}/QRV/${MYCALL}/SAVED/${MODULE_NAME}"
mkdir -p $SAVE_DIR

if [ -f $HOME/.local/share/applications/simplex.desktop ]; then
	rm $HOME/.local/share/applications/simplex.desktop
fi

mkdir -p "${SAVE_DIR}/config"
unlink "$HOME/.config/simplex"
rm -rf "$HOME/.config/simplex"
ln -sTf "${SAVE_DIR}/config" "$HOME/.config/simplex"

mkdir -p "${SAVE_DIR}/share"
unlink "$HOME/.local/share/simplex"
rm -rf "$HOME/.local/share/simplex"
ln -sTf "${SAVE_DIR}/share" "$HOME/.local/share/simplex"

cp ${MODULE_DIR}/applications/simplex.desktop $HOME/.local/share/applications/

sed -i "s:^Exec=.*$:Exec=${SAVE_DIR}/simplex.AppImage:" $HOME/.local/share/applications/simplex.desktop

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE" >> /tmp/.failed-modules.log
