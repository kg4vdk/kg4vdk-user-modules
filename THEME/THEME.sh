#!/bin/bash

# MODULE NAME
MODULE_NAME="THEME"

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

COLOR="Blue"

# Cinnamon theme
gsettings set org.cinnamon.theme name "Mint-Y-Dark-${COLOR}"

# Mint-Y icons
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y-${COLOR}"
gsettings set org.gnome.desktop.interface icon-theme "Mint-Y-${COLOR}"

# Mint-Y-Dark theme
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y-Dark-${COLOR}"
gsettings set org.gnome.desktop.interface gtk-theme "Mint-Y-Dark-${COLOR}"

# Make Downloads fold match
gio set /arcHIVE/Downloads metadata::custom-icon file:///usr/share/icons/Mint-Y-${COLOR}/places/64/folder-download.png
touch /arcHIVE/Downloads

# Inverted images for station-setup
sudo cp "${MODULE_DIR}/images/station-setup-banner_dark.png" /opt/arcOS/images/station-setup-banner.png
sudo cp "${MODULE_DIR}/images/select-operator_dark.png" /opt/arcOS/images/select-operator.png

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
