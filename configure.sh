#!/bin/bash
set -ex

cd $HOME/dotfiles

# Use local or remote state for configuration
echo "Do you wish to discard local, checkout master and pull remote dotfile changes before running configuration?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) git reset HEAD --hard && checkout master && git reset HEAD --hard && git pull; break;;
        No ) break;;
    esac
done

# Start configuration script based on device
read -p "Enter device name (hp14s, spfaus-honor, simon-desktop): " DEVICE_NAME
type $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh && $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh

# Optional reboot
read -p "Press enter to reboot"
reboot
