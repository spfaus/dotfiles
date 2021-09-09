#!/bin/bash
set -ex

cd $HOME/dotfiles

# Check if local dotfile repo is up to date
status=-1
if [ "`git log --pretty=%H ...refs/heads/master^ | head -n 1`" = "`git ls-remote origin -h refs/heads/master |cut -f1`" ]; then
    status=0
    statustxt="Local repository is up to date."
else
    status=2
    statustxt="New changes on remote."
fi

if [[ `git status --porcelain` ]]; then
    status=1
    statustxt="Local repository has uncommitted changes."
fi

if [ $stats -eq -1 ]; then
    echo "Error: Could not verify repo status";
    exit $ERRCODE;
fi

if [ $status -ne 0 ]; then
    echo $statustxt
    echo "Do you wish to discard local changes and pull from remote?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) git reset HEAD --hard && git pull; break;;
            No ) break;;
        esac
    done
fi


# Start configuration script based on device
read -p "Enter device name (hp14s, spfaus-honor, simon-desktop): " DEVICE_NAME
type $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh && $HOME/dotfiles/devices/$DEVICE_NAME/configure.sh

# Optional reboot
read -p "Press enter to reboot"
reboot
