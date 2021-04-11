#!/bin/bash
set -ex

$HOME/dotfiles/config-groups/foundation/configure.sh

$HOME/dotfiles/config-groups/rust/configure.sh
$HOME/dotfiles/config-groups/gamedev/configure.sh
