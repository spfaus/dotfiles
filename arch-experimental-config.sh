#!/bin/bash
set -ex

sudo pacman -Syyu --noconfirm
yay -Syyu --noconfirm

#sudo pacman -Rs --noconfirm rust neovim

sudo pacman -S --noconfirm rustup
yay -S --noconfirm neovim-nightly godot

rustup default stable
