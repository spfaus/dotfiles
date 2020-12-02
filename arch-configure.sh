#!/bin/bash
set -ex

cd $HOME/dotfiles

sudo pacman -Syyu
sudo pacman -S base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gdm i3-gaps i3blocks i3lock rofi alacritty openssh feh

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
rm -rf yay-git

yay -Syyu
yay -S polybar

# Symlink all user config
for file in $(find $HOME/dotfiles/home -type f); do mkdir -p $(dirname $(echo $file | sed -r 's/\/dotfiles\/home//')) && ln -sf $file $(echo $file | sed -r 's/\/dotfiles\/home//'); done

# Symlink all root config
for file in $(find $HOME/dotfiles/root -type f); do sudo mkdir -p $(dirname $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//")) && sudo ln -sf $file $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//"); done


sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service
sudo systemctl daemon-reload

sudo rm -f /usr/share/xsessions/gnome**

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo locale-gen

sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Do additional device-specific configuration
read -p "Enter device name (eg. hp14s): " DEVICE_NAME
type $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh && $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh
