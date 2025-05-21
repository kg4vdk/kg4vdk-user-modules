#!/bin/bash

######################
# PARACON QRV MODULE #
######################
MODULE="PARACON"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)
QRV_PROFILE=$(head -n 7 $HOME/.station-info | tail -n 1)

if [ ${QRV_PROFILE} == ${MYLOC} ]; then
	QRV_PROFILE="NONE"
fi

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Copy launcher into place
cp ${MODULE_DIR}/applications/paracon.desktop $HOME/.local/share/applications

# Ensure launcher points to user's copy
sed -i "s:^Name=.*$:Name=PARACON ($MYCALL):" $HOME/.local/share/applications/paracon.desktop
sed -i "s:^Exec=.*$:Exec=${MODULE_DIR}/bin/start-paracon:" $HOME/.local/share/applications/paracon.desktop

# Copy icon into place
cp ${MODULE_DIR}/icons/paracon-custom-icon.png $HOME/.local/share/icons/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
