filetype plugin on
set number relativenumber
syntax enable

" ---- FUZZY FILE FIND ----
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" :find FILENAME now lets you find any file in root or subdirectories.
" Wildcards are allowed.
" :b UNIQUE_FILENAME_SUBSET lets you instantly jump to any open files (check open
" files with :ls).
