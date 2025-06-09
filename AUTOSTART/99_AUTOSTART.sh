#!/bin/bash

################### USER DEFINED VARIABLES ###################

# Define VNC passwd more secure than "$MYCALL"
VNC_PASSWD="CQCQkg4vdk7373"

################# END USER DEFINED VARIABLES ################

########################
# AUTOSTART QRV MODULE #
########################
MODULE="AUTOSTART"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# If VNC_PASSWD is not empty, set it accordingly
if [ "${VNC_PASSWD}" != "" ]; then
	x11vnc --storepasswd "${VNC_PASSWD}" $HOME/.vnc/passwd
fi

# Start Desktop Sharing
if ! pidof x11vnc > /dev/null 2>&1; then
    sudo systemctl enable --now x11vnc.service > /dev/null 2>&1
    touch /tmp/vnc-active
    notify-send --urgency normal --icon virt-viewer "Desktop Sharing Enabled"
fi

# Start Hexchat minimized to tray
if ! pidof hexchat; then
	hexchat --minimize=2 &
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

