""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set encoding=utf-8
set list  " Shows invisible characters
set listchars=tab:▸\ ,eol:¬
set hlsearch  " Highlight the current search term
set incsearch  " Incremental searching
set ignorecase 	" Insensitive search"
set smartcase 	" Sensitive search in case of capital letters"
set colorcolumn=80
set cursorline " Highlight the line the cursor is on

" Display line number
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set relativenumber  	" for relative number"
set number 		" for current line number"

" Number of text in a line
" set tw=79

" Automatic savings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:auto_save = 1  	" enable AutoSave on Vim startup

" mouse on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a

"  Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
autocmd FileType c colorscheme jelleybeans
autocmd FileType cpp colorscheme jelleybeans
"
set hidden
set wildmenu

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200


