#!/bin/bash
set -ex

yay -S --noconfirm phpstorm-jre phpstorm filezilla thunderbird slack-desktop

ln -sf $HOME/dotfiles/config-groups/work/.gitconfig $HOME/.gitconfig