#!/bin/bash

####################################
# TNSPARC QRV MODULE #
####################################
MODULE="TNSPARC"

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

MYCALL_LOWERCASE=$(echo $MYCALL | tr '[:upper:]' '[:lower:]')

mkdir -p $HOME/.config/goa-1.0
cp ${MODULE_DIR}/config/accounts.conf $HOME/.config/goa-1.0/
sed -i "s/XXXUSERNAMEXXX/${MYCALL_LOWERCASE}/g" $HOME/.config/goa-1.0/accounts.conf

cp ${MODULE_DIR}/docs/ARES-Taskbook.pdf $HOME/

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

