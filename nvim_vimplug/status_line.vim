let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
"
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
"
" "  my symbols
"  let g:airline_left_sep="\uE0B4"
"  let g:airline_left_alt_sep="\uE0B5"
"  let g:airline_right_sep="\uE0B6"
"  let g:airline_right_alt_sep="\uE0B7"
"
"  my symbols
let g:airline_left_sep="\uE0C0"
let g:airline_left_alt_sep="\uE0C1"

if has('macunix')
	let g:airline_right_sep="\uE0C2 "
else
	let g:airline_right_sep="\uE0C2"
endif
let g:airline_right_alt_sep="\uE0C3 "
"

" status line themeing
""  Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme molokai
autocmd FileType c colorscheme jellybeans
autocmd FileType cpp colorscheme jellybeans
"
