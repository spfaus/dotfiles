#!/bin/bash
set -e

cd $HOME/dotfiles

sudo pacman -Sy --noconfirm git reflector rsync
sudo reflector --verbose --country Canada --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -sic --noconfirm
cd ..
rm -rf yay

$HOME/dotfiles/configure.sh
