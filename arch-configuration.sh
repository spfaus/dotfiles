#!/bin/bash
set -ex

#TODO: sudoers

sudo timedatectl set-ntp true

sudo reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

sudo pacman -Syu
./arch-packages-script.sh

sudo ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
sudo hwclock --systohc
sudo ln -s /usr/bin/nvim /usr/bin/vim
sudo ln -s /usr/bin/nvim /usr/bin/vi

# replace
sudo sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
sudo locale-gen
sudo echo "LANG=en_US.UTF-8" > /etc/locale.conf
sudo echo "KEYMAP=de-latin1" > /etc/vconsole.conf

# replace
echo "hp14s" | sudo tee /etc/hostname
echo "127.0.0.1   localhost" | sudo tee /etc/hosts
echo "::1         localhost" | sudo tee -a /etc/hosts
echo "127.0.1.1   hp14s.localdomain hp14s" | sudo tee -a /etc/hosts

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service

# replace - fixes gdm autostart issue
sudo mkdir -p /etc/systemd/system/gdm.service.d/
{ echo "[Service]";
  echo "ExecStartPre=/bin/sleep 1";
} | sudo tee /etc/systemd/system/gdm.service.d/override.conf
daemon-reload

git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ..
rm -rf yay-git

yay -S rtl8821ce-dkms-git
dkms autoinstall
