" ======DEFAULTS======
source $HOME/.config/nvim/default-configs/sensible.vim

" ======PLUGINS======
set nocompatible              " required
filetype off                  " required

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

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

" Practice & good habits
Plugin 'takac/vim-hardtime'

call vundle#end()

" ======CUSTOM CONFIG======
filetype plugin indent on    " required
set autoindent
set encoding=utf-8

" :Files
let $FZF_DEFAULT_COMMAND="rg --files --hidden --ignore-case --iglob !.git"

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
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none

" Highlight characters over 90 columns
match ErrorMsg '\%>90v.\+'

" Show trailing whitespace and tabs if noexpandtab is set
set listchars=tab:\┊\ ,trail:·
"hi Whitespace ctermfg=Grey
set list

" ======PLUGIN CONFIGS======
let g:rustfmt_autosave = 1
let g:hardtime_default_on = 1

source $HOME/.config/nvim/plugin-config/coc.vim
