#!/bin/bash
# This script handles device-specific configuration and is called by the general configuration script.
set -ex

sudo pacman -S filezilla thunderbird chromium

ln -sf $HOME/dotfiles/spfaus-honor/.gitconfig $HOME/.gitconfig
