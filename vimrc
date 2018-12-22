" pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" for nerdtree short cut
map <C-n> :NERDTreeToggle<CR>

" set guifont=Inconsolata\ for\ Powerline:h15
set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

" Powerline fonts
let g:airline_powerline_fonts = 1

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = '🔒'
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.linenr = '␊'
  let g:airline_symbols.linenr = '␤'
  let g:airline_symbols.linenr = '¶'
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.maxlinenr = '㏑'
  let g:airline_symbols.branch = '⎇'
  let g:airline_symbols.paste = 'ρ'
  let g:airline_symbols.paste = 'Þ'
  let g:airline_symbols.paste = '∥'
  let g:airline_symbols.spell = 'Ꞩ'
  let g:airline_symbols.notexists = 'Ɇ'
  let g:airline_symbols.whitespace = 'Ξ'

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = '☰'
  let g:airline_symbols.maxlinenr = ''

  " old vim-powerline symbols
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  " let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'


" Configuration for the llstartpreview  
autocmd Filetype tex setl updatetime=1
autocmd Filetype tex set tw=79
let g:livepreview_previewer = 'open -a Preview'

" for vim-latex-suite
let g:Tex_EnvLabelprefix_equation = "eq:"
let g:Tex_EnvLabelprefix_figure = "fig:"
let g:Tex_EnvLabelprefix_table = "table:"

" default spell check
set spell!

" Display line number
set relativenumber  	" for relative number"
set number 		" for current line number"

" Color scheme
colorscheme molokai
autocmd Filetype python colorscheme dracula

" Automatic savings
let g:auto_save = 1  " enable AutoSave on Vim startup
