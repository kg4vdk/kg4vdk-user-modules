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
LOGFILE="${MODULE_DIR}/${MODULE_NAME}.log"

################################

### MODULE COMMANDS FUNCTION ###
module_commands () {

# Slideshow tweaks (random and faster)
gsettings set org.cinnamon.desktop.background.slideshow random-order true
gsettings set org.cinnamon.desktop.background.slideshow delay 5

# Show seconds in panel clock
jq '.["custom-format"].value = "%a, %b %d%n%H:%M:%S %Z"' $HOME/.config/cinnamon/spices/calendar@cinnamon.org/14.json > /tmp/14.json
mv /tmp/14.json $HOME/.config/cinnamon/spices/calendar@cinnamon.org/14.json

# Show seconds in screensaver clock
gsettings set org.cinnamon.desktop.screensaver date-format '%a, %B %d%n%H:%M:%S %Z'

# Terminal preferences
LEGACY_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ use-theme-colors 'false'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ foreground-color '#FFFFFF'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ background-color '#000000'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ use-theme-transparency 'false'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ use-transparent-background 'true'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ background-transparency-percent '15'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${LEGACY_PROFILE}/ scrollbar-policy 'always'

# Ask for away message when locking screen from menu
gsettings set org.cinnamon.desktop.screensaver ask-for-away-message true

# Change user's fullname
sudo chfn -f "Mike Fisher" user

# Add pat service restart to cron
if ! grep "pat@user.service" /etc/crontab; then
cat << EOF | sudo tee --append /etc/crontab
30 6 * * * root systemctl restart pat@user.service
EOF
sudo systemctl restart cron.service
fi

} # END OF MODULE COMMANDS FUNCTION

# Execute the module commands, and notify the user upon failure
module_commands > $LOGFILE 2>&1 || echo "$MODULE_NAME" >> /tmp/.failed-modules.log
