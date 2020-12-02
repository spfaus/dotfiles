#!/bin/bash
set -ex

cd $HOME/dotfiles

sudo timedatectl set-ntp true

sudo pacman -Syyu
sudo pacman -S base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gdm i3-gaps i3blocks i3status i3lock dmenu alacritty
sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
sudo hwclock --systohc

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi

# replace
sudo sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
echo "KEYMAP=de-latin1" | sudo tee /etc/vconsole.conf

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service

# replace - fixes gdm autostart issue on some devices and only introduces a minimal startup delay
sudo mkdir -p /etc/systemd/system/gdm.service.d/
{ echo "[Service]";
  echo "ExecStartPre=/bin/sleep 1";
} | sudo tee /etc/systemd/system/gdm.service.d/override.conf
sudo systemctl daemon-reload

#TODO: Move this into installation?
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
rm -rf yay-git

yay -Syyu

for file in $(find $HOME/dotfiles/home -type f); do mkdir -p $(dirname $(echo $file | sed -r 's/\/dotfiles\/home//')) && ln -sf $file $(echo $file | sed -r 's/\/dotfiles\/home//'); done

for file in $(find $HOME/dotfiles/root -type f); do sudo mkdir -p $(dirname $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//")) && sudo ln -sf $file $(echo $file | sed -r "s/\/home\/$USER\/dotfiles\/root//"); done

read -p "Enter device name (hp14s, ...): " DEVICE_NAME
type $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh && $HOME/dotfiles/arch-configure-$DEVICE_NAME.sh
