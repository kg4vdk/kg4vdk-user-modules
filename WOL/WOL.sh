#!/bin/bash

# Remove status file
rm /tmp/vnc-active

# Get Ethernet device name
ETH=$(ip -brief link | awk '$1 !~ "lo|vir|wl" { print $1}')

# Enable WoL
sudo ethtool -s ${ETH} wol g

# Start VNC
sudo systemctl enable x11vnc.service

#Create status file
touch /tmp/vnc-active
