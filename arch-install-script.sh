#!/bin/bash

# TODO: Implement error handling - script continues after commands return errorcodes
# TODO: Debug / verification outputs
# TODO: Handle device-specific steps more dynamically

loadkeys de-latin1

timedatectl set-ntp true

cfdisk /dev/nvme0n1

mkfs.ext4 /dev/nvme0n1p3 # TODO: Is sleep prior to this necessary for the partition to be known / to exist?
mkfs.vfat /dev/nvme0n1p1
mkswap /dev/nvme0n1p2

mount /dev/nvme0n1p3 /mnt
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
swapon /dev/nvme0n1p2

reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gdm i3-gaps i3blocks i3status i3lock dmenu

genfstab -U /mnt >> /mnt/etc/fstab

echo "mv ./dotfiles/arch-install-script-chroot.sh /mnt/dotfiles/arch-install-script-chroot.sh" && sleep 2
mv ./dotfiles/arch-install-script-chroot.sh /mnt/arch-install-script-chroot.sh
arch-chroot /mnt ./arch-install-script-chroot.sh

reboot
