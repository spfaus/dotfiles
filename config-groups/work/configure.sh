#!/bin/bash
set -ex

yay -S --noconfirm phpstorm-jre phpstorm filezilla thunderbird slack-desktop docker docker-compose docker-machine chromium vpnc networkmanager-vpnc

sudo systemctl enable docker.service
sudo gpasswd -a $USER docker

ln -sf $HOME/dotfiles/config-groups/work/.gitconfig $HOME/.gitconfig