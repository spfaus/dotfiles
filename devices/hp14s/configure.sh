#!/bin/bash
set -ex

$HOME/dotfiles/config-groups/rust/configure.sh

$HOME/dotfiles/config-groups/foundation/configure.sh

$HOME/dotfiles/config-groups/amd-processor/configure.sh
$HOME/dotfiles/config-groups/rtl8821ce/configure.sh
$HOME/dotfiles/config-groups/private-communication/configure.sh