#!/bin/bash
set -e

SCRIPT_DIR=$(dirname "$0")

cd $SCRIPT_DIR

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

git status

sudo reflector --verbose --latest 10 --sort rate \
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
    amd-ucode discord fish cups bitwarden anki-qt5 python-certifi \
    powerline-shell autojump-rs htop visual-studio-code-bin nordvpn-bin

# Install Visual Studio Code extensions
code \
--install-extension rust-lang.rust-analyzer \
--install-extension bungcip.better-toml \
--install-extension vadimcn.vscode-lldb \
--install-extension serayuzgur.crates \
--install-extension usernamehw.errorlens \
--install-extension a5huynh.vscode-ron \

# Set up NordVPN
groupadd -rf nordvpn
sudo gpasswd -a $USER nordvpn

# Load all dconf settings
dconf load / < $(pwd)/dconf/full-backup

# Link all user config files
cp -as --remove-destination $(pwd)/home/. $HOME/

# Link all root config files and change owner to root
sudo chown -R root:root $(pwd)/root/
sudo cp -as --remove-destination $(pwd)/root/. /

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

echo "------ All done! ------"
