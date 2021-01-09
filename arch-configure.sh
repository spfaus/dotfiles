#!/bin/bash
set -ex

cd $HOME/dotfiles

sudo pacman -Syyu --noconfirm
yay -Syyu --noconfirm

sudo pacman -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gnome gnome-tweaks rustup noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra cups bluez bluez-utils

yay -S --noconfirm gnome-shell-extension-pop-shell yay neovim-nightly visual-studio-code-bin

# Load all dconf settings
dconf load / < ./dconf/full-backup

# Symlink all user config files
for file in $(find $HOME/dotfiles/home -type f); do mkdir -p $(dirname $(echo $file | sed -r 's/\/dotfiles\/home//')) && ln -sf $file $(echo $file | sed -r 's/\/dotfiles\/home//'); done

# Symlink all root config files
sudo chown -R root:root ./root
for file in $(find $HOME/dotfiles/root -type f); do sudo mkdir -p $(dirname $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//")) && sudo ln -sf $file $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//"); done

rustup default stable

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo locale-gen

sudo reflector --verbose --country Germany --latest 50 --sort rate --save /etc/pacman.d/mirrorlist

# Do additional device-specific configuration
read -p "Enter device name (eg. hp14s): " DEVICE_NAME
type $HOME/dotfiles/$DEVICE_NAME/arch-configure.sh && $HOME/dotfiles/$DEVICE_NAME/arch-configure.sh

reboot
