#!/bin/bash
set -ex

yay -Sy --noconfirm rtl8821ce-dkms-git

# Link all root config files and change owner to root
sudo chown -R root:root $HOME/dotfiles/config-groups/rtl8821ce/root/
sudo cp -as --remove-destination $HOME/dotfiles/config-groups/rtl8821ce/root/. /