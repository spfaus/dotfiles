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
echo "Discard local changes and use remote state of git branch?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo git reset HEAD --hard && git pull; break;;
        No ) break;;
    esac
done

sudo reflector --verbose --latest 20 --sort rate \
    --save /etc/pacman.d/mirrorlist

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

rustup default nightly
rustup update
cargo install cargo-watch cargo-edit

yay -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages \
    texinfo networkmanager curl wget rsync git grub efibootmgr dkms linux-headers xorg \
    xorg-server gnome gnome-tweaks noto-fonts noto-fonts-cjk noto-fonts-emoji \
    noto-fonts-extra gnome-shell-extension-pop-shell-git yay neovim ntfs-3g chromium \
    amd-ucode discord fish alacritty cups fortune-mod bitwarden anki-git python-certifi \
    lolcat powerline-shell autojump-rs htop

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

yay -Sy
yay -Rs $(yay -Qdtq) --noconfirm # Delete orphans

# Create SSH key if none is found
if [ ! -f ~/.ssh/id_ed25519 ] ; then
    ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 && echo "Created SSH key" && eval \
        "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && echo "Added new SSH key to ssh-agent"
fi
