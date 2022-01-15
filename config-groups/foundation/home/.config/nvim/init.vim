" https://github.com/VundleVim/Vundle.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" =======================================================
" Load Plugins Start
" =======================================================
" GUI Related
Plugin 'itchyny/lightline.vim'
Plugin 'machakann/vim-highlightedyank'
Plugin 'andymass/vim-matchup'

" fzf
Plugin 'airblade/vim-rooter'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

" Syntax checking generic
Plugin 'vim-syntastic/syntastic'

" Autocomplete
Plugin 'neoclide/coc.nvim'

" Rust
Plugin 'rust-lang/rust.vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
" =======================================================
" Load Plugins End
" =======================================================

" Rust formatting
let g:rustfmt_autosave = 1


" =======================================================
" # Editor settings
" =======================================================
filetype plugin indent on    " required
set autoindent
set encoding=utf-8

"" =======================================================
" # Plugin configs
" =======================================================
source $HOME/.config/nvim/plugin-config/coc.vim
