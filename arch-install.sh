#!/bin/bash
set -ex

loadkeys de-latin1

timedatectl set-ntp true

lsblk
read -p "Enter drive to installl on (eg. nvme0n1): " INSTALL_DRIVE

cfdisk /dev/$INSTALL_DRIVE
sleep 5

lsblk
read -p "Enter EFI, swap, root partitions seperated by spaces (eg. nvme0n1p1 nvme0n1p2 nvme0n1p3: " EFI_PARTITION SWAP_PARTITION ROOT_PARTITION 

mkfs.ext4 /dev/$ROOT_PARTITION
mkfs.vfat /dev/$EFI_PARTITION
mkswap /dev/$SWAP_PARTITION

mount /dev/$ROOT_PARTITION /mnt
mkdir /mnt/efi
mount /dev/$EFI_PARTITION /mnt/efi
swapon /dev/$SWAP_PARTITION

reflector --latest 5 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware grub efibootmgr git

genfstab -U /mnt >> /mnt/etc/fstab

cp ./dotfiles/arch-chroot.sh /mnt
cp ./dotfiles/arch-packages.sh /mnt
arch-chroot /mnt ./arch-chroot.sh
rm /mnt/arch-chroot.sh /mnt/arch-packages.sh

reboot
