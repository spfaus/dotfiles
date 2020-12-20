#!/bin/bash
set -ex

cd $HOME/dotfiles

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sic --noconfirm
cd ..
rm -rf yay
