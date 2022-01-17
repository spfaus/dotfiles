#!/bin/bash
set -ex

cd $HOME/dotfiles

sudo pacman -Sy

if [ ! -x /usr/bin/rsync ] ; then
	sudo pacman -S --noconfirm rsync
fi

if [ ! -x /usr/bin/reflector ] ; then
	sudo pacman -S --noconfirm reflector
fi

if [ ! -x /usr/bin/git ] ; then
	sudo pacman -S --noconfirm git
fi

sudo reflector --verbose --country Canada --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

if [ ! -x /usr/bin/yay ] ; then
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -sic --noconfirm
	cd ..
	rm -rf yay
fi

# Use local or remote state for configuration
git status
echo "Do you wish to discard local changes, checkout master, and pull from remote before running configuration?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) sudo git reset HEAD --hard && git checkout master && git reset HEAD --hard && git pull; break;;
		No ) break;;
	esac
done

# Configure
yay -Syyuu --noconfirm

yay -S --noconfirm rustup clang

rustup default stable
rustup update
cargo install cargo-generate cargo-watch cargo-edit

yay -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages texinfo networkmanager curl wget rsync git grub efibootmgr dkms linux-headers xorg xorg-server gnome gnome-tweaks noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra gnome-shell-extension-pop-shell-git yay neovim ntfs-3g chromium vundle-git nodejs yarn amd-ucode discord fish alacritty ripgrep cups

# Load all dconf settings                                                                                                                                                          
dconf load / < $HOME/dotfiles/dconf/full-backup

# Link all user config files
cp -as --remove-destination $HOME/dotfiles/home/. $HOME/

# Link all root config files and change owner to root
sudo chown -R root:root $HOME/dotfiles/root/
sudo cp -as --remove-destination $HOME/dotfiles/root/. /

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service
sudo systemctl enable cups.service

sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi
sudo ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime

sudo timedatectl set-ntp true
sudo hwclock --systohc
sudo locale-gen

nvim +PluginInstall +PluginClean +PluginUpdate +UpdateRemotePlugins +qall
cd $HOME/.vim/bundle/coc.nvim/
yarn install
cd $HOME/dotfiles/
nvim +"CocInstall coc-rust-analyzer" +qall

yay -Sy
yay -Rs $(yay -Qdtq) --noconfirm # Delete orphans

# Optional reboot
echo "Reboot now?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) reboot; break;;
		No ) break;;
	esac
done
