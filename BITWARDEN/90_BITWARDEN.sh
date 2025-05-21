#!/bin/bash

########################
# BITWARDEN QRV MODULE #
########################
MODULE="BITWARDEN"

# STATION INFO
MYCALL=$(head -n 1 $HOME/.station-info)
MYNAME=$(head -n 2 $HOME/.station-info | tail -n 1)
MYCITY=$(head -n 3 $HOME/.station-info | tail -n 1)
MYST=$(head -n 4 $HOME/.station-info | tail -n 1)
MYQTH="${MYCITY}, ${MYST}"
MYLOC=$(head -n 5 $HOME/.station-info | tail -n 1)

# PATHS
ARCOS_DATA=/ARCOS-DATA
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/$MODULE
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR

if grep "bitwarden" /etc/mtab; then
	sudo umount $HOME/.config/Bitwarden
fi

rm -rf $HOME/.config/Bitwarden
mkdir -p $HOME/.config/Bitwarden

if [ ! -f $SAVE_DIR/bitwarden-fs ]; then
	dd if=/dev/zero of=$SAVE_DIR/bitwarden-fs bs=1M count=128
	mkfs.ext4 $SAVE_DIR/bitwarden-fs
	sudo mount $SAVE_DIR/bitwarden-fs $HOME/.config/Bitwarden
	sudo chown user:user $HOME/.config/Bitwarden
	sudo chmod 700 $HOME/.config/Bitwarden
	sudo umount $HOME/.config/Bitwarden
fi

sudo mount $SAVE_DIR/bitwarden-fs $HOME/.config/Bitwarden

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
