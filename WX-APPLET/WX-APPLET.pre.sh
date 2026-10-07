#!/bin/bash

# MODULE NAME
MODULE_NAME="WX-APPLET"

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

if [ -d "$HOME/.local/share/cinnamon/applets/weather@mockturtl" ]; then
	rm -rf $HOME/.local/share/cinnamon/applets/weather@mockturtl
fi
unzip -d $HOME/.local/share/cinnamon/applets ${MODULE_DIR}/weather@mockturtl.zip
mkdir -p $HOME/.config/cinnamon/spices/weather@mockturtl
cp ${MODULE_DIR}/0.json $HOME/.config/cinnamon/spices/weather@mockturtl

gsettings set org.cinnamon enabled-applets "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:separator@cinnamon.org:1', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:1:workspace-switcher@cinnamon.org:3', 'panel1:right:1:systray@cinnamon.org:4', 'panel1:right:2:xapp-status@cinnamon.org:5', 'panel1:right:3:notifications@cinnamon.org:6', 'panel1:right:4:printers@cinnamon.org:7', 'panel1:right:5:removable-drives@cinnamon.org:8', 'panel1:right:6:keyboard@cinnamon.org:9', 'panel1:right:7:favorites@cinnamon.org:10', 'panel1:right:8:network@cinnamon.org:11', 'panel1:right:9:sound@cinnamon.org:12', 'panel1:right:10:power@cinnamon.org:13', 'panel1:right:11:calendar@cinnamon.org:14', 'panel1:right:0:weather@mockturtl:0']"

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
