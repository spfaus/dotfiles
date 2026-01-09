#!/bin/bash
set -e

SCRIPT_DIR=$(dirname "$0")

cd $SCRIPT_DIR

sudo pacman -Sy archlinux-keyring --noconfirm

if [ ! -x /usr/bin/rsync ] ; then
    sudo pacman -S --noconfirm rsync
fi

if [ ! -x /usr/bin/reflector ] ; then
    sudo pacman -S --noconfirm reflector
fi

if [ ! -x /usr/bin/git ] ; then
    sudo pacman -S --noconfirm git
fi

git remote set-url origin git@github.com:spfaus/dotfiles.git
git config user.name "spfaus"
git config user.email "simon.pfaus@web.de"
git status

sudo reflector --verbose --protocol https --latest 20 --sort rate \
    --save /etc/pacman.d/mirrorlist

if [ ! -x /usr/bin/yay ] ; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -sic --noconfirm
    cd ..
    rm -rf yay
fi

yay -Syyuu --noconfirm

sudo pacman -S gnome xorg --noconfirm

yay -S --noconfirm base base-devel linux linux-firmware reflector sudo man-db man-pages \
    texinfo networkmanager curl wget rsync git grub efibootmgr dkms linux-headers \
    xorg-server gnome-tweaks noto-fonts noto-fonts-cjk noto-fonts-emoji \
    noto-fonts-extra ttf-jetbrains-mono-nerd gnome-shell-extension-pop-shell-git yay ntfs-3g chromium \
    amd-ucode bitwarden anki-bin \
    neovim \
    htop \
    grub-customizer \
    libfido2 \
    authenticator \
    ncdu \
    tldr \
    zoxide \
    fzf \
    mpv \
    odin odinfmt \
    tree \
    xclip \
    activitywatch-bin gnome-shell-extension-focused-window-dbus-git aw-awatcher \
    jq \
    ibus-mozc \
    macchanger

# Load all dconf settings
dconf load / < $(pwd)/dconf/full-backup

# Link all user config files
cp -as --remove-destination $(pwd)/home/. $HOME/

# Link all root config files and change owner to root
sudo chown -R root:root $(pwd)/root/
sudo cp -as --remove-destination $(pwd)/root/. /

sudo systemctl enable NetworkManager.service
sudo systemctl enable gdm.service
systemctl --user enable aw-server.service aw-awatcher.service

sudo sed -i -e 's/#Color/Color/g' /etc/pacman.conf


sudo ln -sf /usr/bin/nvim /usr/bin/vim
sudo ln -sf /usr/bin/nvim /usr/bin/vi

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
