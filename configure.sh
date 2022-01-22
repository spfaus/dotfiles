#!/bin/bash
set -e

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

# Use local or remote state for configuration
git status
echo "Use local or remote version of git branch? (Remote will discard local)"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo git reset HEAD --hard && git pull; break;;
        No ) break;;
    esac
done

sudo reflector --verbose --country Canada --latest 20 --sort rate --save /etc/pacman.d/mirrorlist

if [ ! -x /usr/bin/yay ] ; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sic --noconfirm
    cd ..
    rm -rf yay
fi

# Configure
yay -Syyuu --noconfirm

yay -S --noconfirm rustup clang

rustup default stable
rustup update
cargo install cargo-generate cargo-watch cargo-edit

yay -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages texinfo networkmanager curl wget rsync git grub efibootmgr dkms linux-headers xorg xorg-server gnome gnome-tweaks noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra gnome-shell-extension-pop-shell-git yay neovim ntfs-3g chromium vundle-git nodejs yarn amd-ucode discord fish alacritty ripgrep cups fortune-mod lolcat

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

# TODO: +qall does not work with async operations because it does not wait for them to finish
nvim +PluginInstall +PluginClean +PluginUpdate +UpdateRemotePlugins +qall
cd $HOME/.vim/bundle/coc.nvim/
yarn install
cd $HOME/dotfiles/
nvim +"CocInstall coc-rust-analyzer" +qall

yay -Sy
yay -Rs $(yay -Qdtq) --noconfirm # Delete orphans

# Create SSH key if none is found
if [ ! -f ~/.ssh/id_ed25519 ] ; then
    ssh-keygen -t ed25519 -C "simon.pfaus@web.de" -N "" -f ~/.ssh/id_ed25519 && echo "Created SSH key"
fi

# Optional reboot
echo "Reboot now?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) reboot; break;;
        No ) break;;
    esac
done
