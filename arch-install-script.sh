#!/bin/bash

echo "NEXT: loadkeys de-latin1" && sleep 2
loadkeys de-latin1

echo "NEXT: pacman -Syu" && sleep 2
pacman -Syu

echo "NEXT: timedatectl set-ntp true" && sleep 2
timedatectl set-ntp true

echo "NEXT: cfdisk /dev/nvme0n1" && sleep 2
cfdisk /dev/nvme0n1

echo "NEXT: mkfs.ext4 /dev/nvme0n1p3" && sleep 2
mkfs.ext4 /dev/nvme0n1p3
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

echo "NEXT: arch-chroot /mnt" && sleep 2
arch-chroot /mnt
echo "NEXT: pacman -Syu" && sleep 2
pacman -Syu

echo "NEXT: ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime" && sleep 2
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "NEXT: hwclock --systohc" && sleep 2
hwclock --systohc

echo "NEXT: sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen" && sleep 2
sed -i -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
echo "NEXT: locale-gen" && sleep 2
locale-gen
echo "NEXT: echo \"LANG=en_US.UTF-8\" > /etc/locale.conf" && sleep 2
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "NEXT: echo \"KEYMAP=de-latin1\" > /etc/vconsole.conf" && sleep 2
echo "KEYMAP=de-latin1" > /etc/vconsole.conf

echo "NEXT: echo \"hp14s\" > /etc/hostname" && sleep 2
echo "hp14s" > /etc/hostname
echo "NEXT: echo \"127.0.0.1   localhost\" >> /etc/hosts" && sleep 2
echo "127.0.0.1   localhost" >> /etc/hosts
echo "NEXT: echo \"::1         localhost\" >> /etc/hosts" && sleep 2
echo "::1         localhost" >> /etc/hosts
echo "NEXT: echo \"127.0.1.1   hp14s.localdomain hp14s\" >> /etc/hosts" && sleep 2
echo "127.0.1.1   hp14s.localdomain hp14s" >> /etc/hosts

echo "NEXT: echo \"Enter root password\"" && sleep 2
echo "Enter root password"
echo "NEXT: passwd" && sleep 2
passwd

echo "NEXT: grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB" && sleep 2
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
echo "NEXT: grub-mkconfig -o /boot/grub/grub.cfg" && sleep 2
grub-mkconfig -o /boot/grub/grub.cfg

echo "NEXT: ln -s /usr/bin/nvim /usr/bin/vim" && sleep 2
ln -s /usr/bin/nvim /usr/bin/vim
echo "NEXT: ln -s /usr/bin/nvim /usr/bin/vi" && sleep 2
ln -s /usr/bin/nvim /usr/bin/vi

echo "NEXT: useradd -m simon" && sleep 2
useradd -m simon
echo "NEXT: echo \"Enter user password\"" && sleep 2
echo "Enter user password"
echo "NEXT: passwd simon" && sleep 2
passwd simon
echo "NEXT: sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers" && sleep 2
#sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers # Not having this set helps with further configuration. This should be set at the end of the script or if an error occurs. 
sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers

echo "NEXT: git clone https://aur.archlinux.org/yay-git.git" && sleep 2
git clone https://aur.archlinux.org/yay-git.git
echo "NEXT: chown -R simon:simon ./yay-git" && sleep 2
chown -R simon:simon ./yay-git
echo "NEXT: cd yay-git" && sleep 2
cd yay-git
echo "NEXT: su -c \"makepkg -si\" simon" && sleep 2
su -c "makepkg -si" simon
echo "NEXT: cd .." && sleep 2
cd ..
echo "NEXT: rm -rf yay-git" && sleep 2
rm -rf yay-git

echo "NEXT: su -c \"yay -S rtl8821ce-dkms-git\" simon" && sleep 2
su -c "yay -S rtl8821ce-dkms-git" simon
echo "NEXT: dkms autoinstall" && sleep 2
dkms autoinstall
#nmtui

echo "NEXT: systemctl enable gdm.service" && sleep 2
systemctl enable gdm.service
echo "NEXT: systemctl edit gdm" && sleep 2
systemctl edit gdm

echo "NEXT: sed -i -e 's/# Defaults targetpw/Defaults targetpw/g'" && sleep 2
sed -i -e 's/# Defaults targetpw/Defaults targetpw/g'

echo "NEXT: exit" && sleep 2
exit
echo "NEXT: reboot" && sleep 2
reboot
