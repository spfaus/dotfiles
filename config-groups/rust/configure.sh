#!/bin/bash
set -ex

yay -Rs --noconfirm rust # Conflicts with rustup
yay -Sy --noconfirm rustup clang

rustup default stable
rustup update
cargo install cargo-generate cargo-watch
