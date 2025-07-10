#!/bin/bash

##################
# ZSH QRV MODULE #
##################
MODULE="ZSH"

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
ARCOS_DATA=/arcHIVE
MODULE_DIR=$ARCOS_DATA/QRV/$MYCALL/arcos-linux-modules/USER/$MODULE
LOGFILE=$MODULE_DIR/$MODULE.log
SAVE_DIR=$MODULE_DIR/SAVED
QRV_PROFILE_DIR=$ARCOS_DATA/QRV/$MYCALL/SAVED/PROFILES
########################

### MODULE COMMANDS FUNCTION ###
module_commands () {

mkdir -p $SAVE_DIR
if [ ! -f $SAVE_DIR/zsh_history ]; then
	touch $SAVE_DIR/zsh_history
fi

rm -rf $HOME/{.zshrc,.zsh_history,.oh-my-zsh,.p10k.zsh}

cp $MODULE_DIR/config/zshrc $HOME/.zshrc
ln -sTf $SAVE_DIR/zsh_history $HOME/.zsh_history
cp $MODULE_DIR/config/p10k.zsh $HOME/.p10k.zsh
tar -C $HOME -xaf $MODULE_DIR/config/oh-my-zsh.tar.gz

if ! tail -n 1 $HOME/.bashrc | grep "zsh"; then
	echo -e "\n\n# Default to zsh\nzsh" >> $HOME/.bashrc
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || notify-send --icon=error "$MODULE" "$MODULE module failed!"
