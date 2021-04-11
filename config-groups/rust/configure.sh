#!/bin/bash
set -ex

yay -S --noconfirm rustup clang

rustup default stable
rustup update
cargo install cargo-generate cargo-watch