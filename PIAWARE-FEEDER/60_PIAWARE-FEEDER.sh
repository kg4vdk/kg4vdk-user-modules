#!/bin/bash

################### USER DEFINED VARIABLES ###################

# Define feeder id
FEEDER_ID=""

################# END USER DEFINED VARIABLES ################

#############################
# PIAWARE-FEEDER QRV MODULE #
#############################
MODULE="PIAWARE-FEEDER"

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

# If NWS Station is empty use the national map
if [ "${FEEDER_ID}" != "" ]; then
	echo "${FEEDER_ID}" | sudo tee /var/cache/piaware/feeder_id
	sudo systemctl restart piaware.service
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"

