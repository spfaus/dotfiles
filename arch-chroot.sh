#!/bin/bash

# To be executed upon arch-chroot

#necessary?
echo "hp14s" > /etc/hostname
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   hp14s.localdomain hp14s" >> /etc/hosts

echo "Enter root password"
passwd

grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

useradd -m simon
echo "Enter user password"
passwd simon
sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers
sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers

#TODO: find way to run configuration script only once after next reboot or execute directly as user
