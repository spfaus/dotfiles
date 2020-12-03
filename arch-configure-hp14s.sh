#!/bin/bash
# This script handles device-specific configuration for the hp14s and is called by the general configuration script.

set -ex

yay -S --noconfirm rtl8821ce-dkms-git
sudo dkms autoinstall
