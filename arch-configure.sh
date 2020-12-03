#!/bin/bash
#TODO: Automatically skip unnecessary steps that take a long time
set -ex

cd $HOME/dotfiles

sudo pacman -Syyu --noconfirm
sudo pacman -S --noconfirm base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gnome gnome-tweaks

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -sic --noconfirm
cd ..
rm -rf yay-git

yay -Syyu --noconfirm
yay -S --noconfirm gnome-shell-extension-pop-shell

#TODO: Get changes from outside dotfiles	before symlinking them out again. Maybe manual handling?

# Load all dconf settings
dconf load / < ./dconf/full-backup

# Symlink all user config
for file in $(find $HOME/dotfiles/home -type f); do mkdir -p $(dirname $(echo $file | sed -r 's/\/dotfiles\/home//')) && ln -sf $file $(echo $file | sed -r 's/\/dotfiles\/home//'); done

# Symlink all root config
for file in $(find $HOME/dotfiles/root -type f); do sudo mkdir -p $(dirname $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//")) && sudo ln -sf $file $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//"); done

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo locale-gen

sudo reflector --latest 50 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# TODO: Catch error on unknown device
# Do additional device-specific configuration
read -p "Enter device name (eg. hp14s): " DEVICE_NAME
type $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh && $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh

reboot
