#!/bin/bash
set -ex

cd $HOME/dotfiles

# Start configuration script based on device
read -p "Enter device name (hp14s, spfaus-honor, simon-desktop): " DEVICE_NAME
type $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh && $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh

# Optional reboot
read -p "Press enter to reboot"
reboot
