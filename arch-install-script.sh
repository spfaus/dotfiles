#!/bin/bash

loadkeys de-latin1

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

# root password
passwd

echo "All done!"
