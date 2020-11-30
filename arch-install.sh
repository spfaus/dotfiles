#!/bin/bash
set -ex

loadkeys de-latin1

timedatectl set-ntp true

cfdisk /dev/nvme0n1
sleep 5

mkfs.ext4 /dev/nvme0n1p3
mkfs.vfat /dev/nvme0n1p1
mkswap /dev/nvme0n1p2

mount /dev/nvme0n1p3 /mnt
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
swapon /dev/nvme0n1p2

reflector --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base linux linux-firmware grub efibootmgr

genfstab -U /mnt >> /mnt/etc/fstab

cp ./dotfiles/arch-install-script-chroot.sh /mnt
cp ./dotfiles/arch-packages-script.sh /mnt
arch-chroot /mnt ./arch-install-script-chroot.sh
rm /mnt/arch-install-script-chroot.sh /mnt/arch-packages-script.sh

#deactivated for debugging
#reboot