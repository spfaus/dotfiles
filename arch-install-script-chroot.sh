#!/bin/bash

# To be executed upon arch-chroot

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

systemctl enable NetworkManager.service

echo "Enter root password"
passwd

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

ln -s /usr/bin/nvim /usr/bin/vim
ln -s /usr/bin/nvim /usr/bin/vi

useradd -m simon
echo "Enter user password"
passwd simon
sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers
sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers # Security risk, needs to be fixed, even in case of error

git clone https://aur.archlinux.org/yay-git.git
chown -R simon:simon ./yay-git
cd yay-git
su -c "makepkg -si" simon 
cd ..
rm -rf yay-git

su -c "yay -S rtl8821ce-dkms-git" simon
dkms autoinstall

systemctl enable gdm.service
sudo mkdir -p /etc/systemd/system/gdm.service.d/
{ echo "[Service]"; 
  echo "ExecStartPre=/bin/sleep 1";
} | sudo tee /etc/systemd/system/gdm.service.d/gdm.conf
sudo systemctl daemon-reload

sed -i -e 's/ALL ALL=(ALL) NOPASSWD: ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers # Fixes earlier security vulnerability (if script gets to this point)
