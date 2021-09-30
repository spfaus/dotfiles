#!/bin/bash
set -e

yay -S --noconfirm phpstorm-jre phpstorm slack-desktop firefox-developer-edition chromium microsoft-edge-dev-bin vpnc networkmanager-vpnc docker docker-compose docker-machine zoom

sudo systemctl enable docker.service
sudo gpasswd -a $USER docker

ln -sf $HOME/dotfiles/config-groups/work/.gitconfig $HOME/.gitconfig
