#!/bin/bash

loadkeys de-latin1

pacman -Syu

timedatectl set-ntp true

cfdisk /dev/nvme0n1

mkfs.ext4 /dev/nvme0n1p3
mkfs.vfat /dev/nvme0n1p1
mkswap /dev/nvme0n1p2

mount /dev/nvme0n1p3 /mnt
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
swapon /dev/nvme0n1p2

reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gnome

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
pacman -Syu

ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

echo "hp14s" > /etc/hostname
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   hp14s.localdomain hp14s" >> /etc/hosts

echo "Enter root password"
passwd

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

ln -s /usr/bin/nvim /usr/bin/vim
ln -s /usr/bin/nvim /usr/bin/vi

useradd -m simon
echo "Enter user password"
passwd simon
#sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers # Not having this set helps with further configuration. This should be set at the end of the script or if an error occurs. 
sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers

git clone https://aur.archlinux.org/yay-git.git
chown -R simon:simon ./yay-git
cd yay-git
su -c "makepkg -si" simon
cd ..
rm -rf yay-git

su -c "yay -S rtl8821ce-dkms-git" simon
dkms autoinstall
#nmtui

systemctl enable gdm.service
systemctl edit gdm

sed -i -e 's/# Defaults targetpw/Defaults targetpw/g'

reboot
