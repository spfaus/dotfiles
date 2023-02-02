" ======DEFAULTS======
source $HOME/.config/nvim/default-configs/sensible.vim

" ======CUSTOM CONFIG======
filetype plugin indent on    " required
set autoindent
set encoding=utf-8

" Permanent undo
set undodir=~/.vim/undodir
set undofile
set noswapfile
set nobackup

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

set completeopt=menuone,menu,noinsert,noselect

set noexrc
set updatetime=100
set noerrorbells
set hidden
set noshowmode
set scrolloff=8
set nowrap
set signcolumn=number
set cmdheight=2
set relativenumber
set nu

set ignorecase smartcase
set incsearch
set hlsearch

set notermguicolors

" Show trailing whitespace and tabs if noexpandtab is set
set list
set listchars=tab:\┊\ ,trail:·
