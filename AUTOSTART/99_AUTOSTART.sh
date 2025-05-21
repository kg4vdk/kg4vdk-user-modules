#!/bin/bash

########################
# AUTOSTART QRV MODULE #
########################

# Nmae of the module directory
MODULE="AUTOSTART"

# STATION INFO (Gets information from the .station-info file in the user home directory)
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS (Defines paths referencein the module)
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

QRV_PROFILE=$(head -n 7 $HOME/.station-info | tail -n 1)

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Change profile name as appropriate (ALL CAPS)
if [[ "${QRV_PROFILE}" = "DEFAULT" ]]; then
	#gtk-launch yaac.desktop & # Launch YAAC
	gtk-launch webapp-WinlinkClient0335.desktop & # Launch Pat
	gtk-launch start-direwolf.desktop & # Launch Direwolf
fi

##################################################
} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
