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
" set colorcolumn=80
set cursorline " Highlight the line the cursor is on
set scrolloff=5

highlight ColorColumn ctermbg=magenta "set to whatever you like
call matchadd('ColorColumn', '\%81v', 80) "set column number

" let &colorcolumn="80,".join(range(120,999),",")
" " Display line number
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

set backupdir=~/.cache/vim 	" Directory to store backup files.
set dir=~/.cache/vim 	" Directory to store swap files.
set history=1000 	"" Increase the undo limit.


let g:UltiSnipsUsePythonVersion=3
" vertically split ultisnips edit window
let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories=["custom_snippets", "UltiSnips"]
" let g:UltiSnipsSnippetsDir="~/.vim/snippet_custom/"


let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

" Setup plugins for editing prose
let g:airline_section_x = '%{PencilMode()}'
" let g:lexical#spell = 0
nnoremap <silent> <leader>s :NextWordy<cr>
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#concealcursor = 'nc'
let g:pencil#conceallevel = 0
augroup pencil
	autocmd!
	autocmd FileType pandoc,markdown,mkd,text,tex,sile,usfm
		" \  call lexical#init()
		\| call textobj#sentence#init()
		\| call textobj#quote#init({'educate': 0})
		\| call pencil#init()
augroup END


" settings for presentation
let g:presenting_statusline = '%l, %c of %{b:presenting_page_current}/%{b:presenting_page_total}'
let g:presenting_top_margin = 2
