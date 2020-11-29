#!/bin/bash

# TODO: Implement error handling - script continues after commands return errorcodes
# TODO: Debug / verification outputs

echo "NEXT: loadkeys de-latin1" && sleep 2
loadkeys de-latin1

echo "NEXT: pacman -Syu" && sleep 2
pacman -Syu

echo "NEXT: timedatectl set-ntp true" && sleep 2
timedatectl set-ntp true

echo "NEXT: cfdisk /dev/nvme0n1" && sleep 2
cfdisk /dev/nvme0n1

echo "NEXT: mkfs.ext4 /dev/nvme0n1p3" && sleep 2
mkfs.ext4 /dev/nvme0n1p3 # TODO: Is sleep prior to this necessary for the partition to be known / to exist?
echo "NEXT: mkfs.vfat /dev/nvme0n1p1" && sleep 2
mkfs.vfat /dev/nvme0n1p1
echo "NEXT: mkswap /dev/nvme0n1p2" && sleep 2
mkswap /dev/nvme0n1p2

echo "NEXT: mount /dev/nvme0n1p3 /mnt" && sleep 2
mount /dev/nvme0n1p3 /mnt
echo "NEXT: mkdir /mnt/efi" && sleep 2
mkdir /mnt/efi
echo "NEXT: mount /dev/nvme0n1p1 /mnt/efi" && sleep 2
mount /dev/nvme0n1p1 /mnt/efi
echo "NEXT: swapon /dev/nvme0n1p2" && sleep 2
swapon /dev/nvme0n1p2

echo "NEXT: reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist" && sleep 2
reflector --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "NEXT: pacstrap /mnt base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gnome" && sleep 2
pacstrap /mnt base base-devel linux linux-firmware neovim reflector sudo man-db man-pages texinfo networkmanager curl git firefox-developer-edition grub efibootmgr amd-ucode dkms linux-headers xorg xorg-server gnome

echo "NEXT: genfstab -U /mnt >> /mnt/etc/fstab" && sleep 2
genfstab -U /mnt >> /mnt/etc/fstab

echo "mv ./dotfiles/arch-install-script-chroot.sh /mnt/dotfiles/arch-install-script-chroot.sh" && sleep 2
mv ./dotfiles/arch-install-script-chroot.sh /mnt/dotfiles/arch-install-script-chroot.sh
echo "NEXT: arch-chroot /mnt" && sleep 2
arch-chroot /mnt ./arch-install-script-chroot.sh

echo "NEXT: reboot" && sleep 2
reboot
