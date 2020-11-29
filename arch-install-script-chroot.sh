#!/bin/bash

# To be executed upon arch-chroot

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
echo "NEXT: sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers" && sleep 2
sed -i -e 's/# Defaults targetpw/Defaults targetpw/g' /etc/sudoers
echo "NEXT: sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers" && sleep 2
sed -i -e 's/# ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers # Security risk, needs to be fixed, even in case of error

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

echo "NEXT: systemctl enable gdm.service" && sleep 2
systemctl enable gdm.service
#echo "NEXT: systemctl edit gdm" && sleep 2
#systemctl edit gdm # Does not work in script?

echo "NEXT: sed -i -e 's/ALL ALL=(ALL) NOPASSWD: ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers" && sleep 2
sed -i -e 's/ALL ALL=(ALL) NOPASSWD: ALL/ALL ALL=(ALL) ALL/g' /etc/sudoers # Fixes earlier security vulnerability (if script gets to this point)
