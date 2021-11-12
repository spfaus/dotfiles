#!/bin/bash
set -e

yay -S --noconfirm phpstorm-jre phpstorm slack-desktop vpnc networkmanager-vpnc docker docker-compose docker-machine

sudo systemctl enable docker.service
sudo gpasswd -a $USER docker

ln -sf $HOME/dotfiles/config-groups/work/.gitconfig $HOME/.gitconfig
