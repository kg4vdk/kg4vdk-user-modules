#!/bin/bash

# MODULE NAME
MODULE_NAME="TWEAKS"

# STATION INFO
source "$HOME/.station-info"
MYCALL_LOWER=$(echo "${MYCALL}" | tr '[:upper:]' '[:lower:]')

# PATHS
ARCHIVE="/arcHIVE"
USER_MODULE_DIR="${ARCHIVE}/QRV/${MYCALL}/arcos-linux-modules/USER"
MY_MODULE_REPO="${USER_MODULE_DIR}/${MYCALL_LOWER}-user-modules"
MODULE_DIR="${MY_MODULE_REPO}/${MODULE_NAME}"
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.pre.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Set custom folder/emblem for "GO-BOX"
if [ -d "/arcHIVE/QRV/${MYCALL}/GO-BOX" ]; then
	gio set "/arcHIVE/QRV/${MYCALL}/GO-BOX" metadata::custom-icon file:///home/user/.local/share/icons/halliburton.png
	touch "/arcHIVE/QRV/${MYCALL}/GO-BOX"

	ln -s "/arcHIVE/QRV/${MYCALL}/GO-BOX" $HOME/Desktop/GO-BOX
	gio set "$HOME/Desktop/GO-BOX" metadata::custom-icon file:///home/user/.local/share/icons/halliburton.png
	touch "$HOME/Desktop/GO-BOX"
fi

# Create bookmark for "GO-BOX"
if ! grep "GO-BOX" $HOME/.config/gtk-3.0/bookmarks; then
	echo "file:///arcHIVE/QRV/${MYCALL}/GO-BOX GO-BOX" >> $HOME/.config/gtk-3.0/bookmarks
else
	sed -i "s;file:///arcHIVE/QRV/.*/GO-BOX.*$;file:///arcHIVE/QRV/${MYCALL}/GO-BOX GO-BOX;" $HOME/.config/gtk-3.0/bookmarks
fi

# Create bookmark for user modules
if ! grep "${MYCALL_LOWER}-user-modules" $HOME/.config/gtk-3.0/bookmarks; then
	echo "file:///arcHIVE/QRV/${MYCALL}/arcos-linux-modules/USER/${MYCALL_LOWER}-user-modules ${MYCALL_LOWER}-user-modules" >> $HOME/.config/gtk-3.0/bookmarks
else
	sed -i "s;file:///arcHIVE/QRV/${MYCALL}/arcos-linux-modules/USER/.*$;file:///arcHIVE/QRV/${MYCALL}/arcos-linux-modules/USER/${MYCALL_LOWER}-user-modules ${MYCALL_LOWER}-user-modules;" $HOME/.config/gtk-3.0/bookmarks
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
