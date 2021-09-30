#!/bin/bash
set -e

sudo reflector --verbose --country Germany --latest 50 --sort rate --save /etc/pacman.d/mirrorlist

yay -Syyu --noconfirm

yay -S --noconfirm rustup clang

rustup default stable
rustup update
cargo install cargo-generate cargo-watch

yay -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages texinfo networkmanager curl wget rsync cups bluez bluez-utils git grub efibootmgr dkms linux-headers xorg xorg-server gnome gnome-tweaks noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra gnome-shell-extension-pop-shell-git yay visual-studio-code-bin otf-hasklig neovim ntfs-3g filezilla thunderbird

# Load all dconf settings
dconf load / < $HOME/dotfiles/config-groups/foundation/dconf/full-backup

# Link all user config files
cp -as --remove-destination $HOME/dotfiles/config-groups/foundation/home/. $HOME/

# Link all root config files and change owner to root
sudo chown -R root:root $HOME/dotfiles/config-groups/foundation/root/
sudo cp -as --remove-destination $HOME/dotfiles/config-groups/foundation/root/. /

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service
sudo systemctl enable cups.service
sudo systemctl enable bluetooth.service

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
sudo ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo locale-gen

yay -Sy
