let mapleader = "\<Space>"

""let ma pleader=","
"map <Space> <lade>
" default spell check
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set spell!
imap <C-f> <C-g>u<Esc>[s1z=`]a<C-g>u
nmap <C-f> [s1z=<C-o>

" Tabbing windows
nnoremap <C-k> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
imap <C-k> <Esc>:tabprevious<CR>
imap <C-l> <Esc>:tabnext<CR>
imap <C-e> <Esc> :tabe
nmap <C-e> :tabe

" 1. nerdtree short cut
imap <C-t> <Esc>:NERDTreeToggle<CR>
nmap <C-t> :NERDTreeToggle<CR>
"  Sign
"  let g:NERDTreeDirArrowExpandable = '\uf35a'
"  let g:NERDTreeDirArrowCollapsible = '\uf358'
"
"
""""""""""""""""""""""""""""""""""""""

let g:SimpylFold_docstring_preview = 1
""""""""""""""""""""""""""""""""""""""
"  3. Snippets
"  UltiSnips trigger since contradict with youcomplete me
let g:UltiSnipsExpandTrigger="<C-w>"
let g:ultisnips_python_style="doxygen"
"
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
"
let g:deoplete#enable_at_startup = 1"
""""""""""""""""""""""""""""""""""""""
"  4. latex plugins
"  Configuration for the llstartpreview
autocmd Filetype tex setl updatetime=1
" autocmd Filetype tex set tw=79
if has('macunix')
	let g:livepreview_previewer = 'open -a Preview'
else
	let g:livepreview_previewer = 'zathura'
endif
" let g:livepreview_previewer = 'evince'
"
"  for vim-latex-suite
let g:tex_flavor='latex'
let g:Tex_EnvLabelprefix_equation = "eq:"
let g:Tex_EnvLabelprefix_figure = "fig:"
let g:Tex_EnvLabelprefix_table = "table:"
let g:Tex_Env_figure="\\begin{figure}[<+htpb+>]\<cr>\\centering\<cr>\\includegraphics[width=0.75\\textwidth]{<+file+>}\<cr>\\caption{<+caption text+>}\<cr>\\label{fig:<+label+>}\<cr>\\end{figure}\<cr><++>"
"
"
""""""""""""""""""""""""""""""""""""""
"  5. YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from
" Ctags file
let g:ycm_use_ultisnips_completer = 1  "Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1  "Completion for programming
" language's keyword
let g:ycm_complete_in_comments = 1  "Completion in comments
let g:ycm_complete_in_strings = 1  "Completion in string
"
"
""""""""""""""""""""""""""""""""""""""
"  6. Git Plugins
"  gitgutter settings
let g:gitgutter_highlight_lines = 0 
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'
"
"
"""""""""""""""""""""""""""""""""""""""
" 7. Auto Parentheses
let g:AutoPairsFlyMode = 1
autocmd Filetype tex let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '```':'```', '"""':'"""', "'''":"'''"}
"
"
""""""""""""""""""""""""""""""""""""""
"  8. File management / search
"  Ctrl+p will search for files in both normal and insert mode
imap <C-p> <Esc> :CtrlP<CR>
"
"
""""""""""""""""""""""""""""""""""""""
"  9. Using Comment's for different file extensions
"
"
"
"""""""""""""""""""""""""""""""""""""""
" 10. Word search plugin
"
"
"
""""""""""""""""""""""""""""""""""""""
"  11. Format documents
"
"
"
"""""""""""""""""""""""""""""""""""""""
" 12. Title Case (First letter capitalization)
"
"
"
"  Run interactive python3
autocmd Filetype python imap <F5> <Esc>:w<CR>:!clear;python %<CR>
"
" 15. cht.sh
let g:CheatSheetFrameworks = {
			\ 'python' : ['python', 'django', ],
			\ 'php' : ['php', 'symphony', 'yii', 'zend'],
			\}
let g:CheatSheetFrameworkDetectionMethods = {
			\'django' : { 'type' : 'file', 'value' : 'manage.py'  },
			\'jquery' : {'type' :'search', 'value' : 'jquery.*\.js'},
			\}

let  g:CheatSheetProviders = ['syntastic']
" Vim command used to open new buffer
let g:CheatSheetReaderCmd='new"'
"
"  Cheat sheet file type
let g:CheatSheetFt='markdown'
"
" Program used to retrieve cheat sheet with its arguments
let g:CheatSheetUrlGetter='curl --silent'

" Flag to add cookie file to the query
let g:CheatSheetUrlGetterIdFlag='-b'
"
"  cheat sheet base url
let g:CheatSheetBaseUrl='https://cht.sh'
"
" cheat sheet settings do not include style settings neiter comments,
" see other options below
let g:CheatSheetUrlSettings='q'
"
"  cheat sheet pager
let g:CheatPager='less -R'
"
" pygmentize theme used for pager output, see :CheatPager :styles-demo
" let g:CheatSheetPagerStyle=rrt
"
"  Show comments in answers by default
"  (setting this to 0 means giving ?Q to the server)
let g:CheatSheetShowCommentsByDefault=1
"
"  cheat sheet buffer name
let g:CheatSheetBufferName="_cheat"
"
"  Default selection in normal mode (line for whole line, word for word under
" cursor)
let g:CheatSheetDefaultSelection="line"
"
"""""  Default query mode
"  0 => buffer
"  1 => replace (do not use or you might loose some lines of code)
"  2 => pager
"  3 => paste after query
"  4 => paste before query
let g:CheatSheetDefaultMode=2
"
"  Path to cheat sheet cookie
let g:CheatSheetIdPath=expand('~/.cht.sh/id')
"
"
"
" 16. Supertab for compatibility problem
" YouCompleteMe and UltiSnipsiSnips compatibility, with the helper of supertab
"  (via http://stackoverflow.com/a/22253548/1626737)
"let g:SuperTabDefaultCompletionType    = '<tab>'
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'
let g:ycm_key_list_select_completion   = ['<C-j>', '<C-n>', '<Down>']
let g:ycm_key_list_select_completion   = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<C-p>', '<Up>']
"

" 18 Multi cursor
" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" reload Vim con fig
imap <C-r> <Esc>:w <Cr> :source ~/.config/nvim/init.vim <Cr>i

" Disable Arrow keys in Escape mode
map <up> <Esc>dd2kp
map <down> <Esc>ddp
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <Esc>dd2kpi
imap <down> <Esc>ddpi
imap <left> <nop>
imap <right> <nop> 

" Disable Arrow keys in Insert mode
vmap <up> <nop>
vmap <down> <nop>
vmap <right> <nop>
vmap <left> <nop>

" mapping compilation and run
autocmd Filetype tex nnoremap <leader>l <Esc>:w <Cr> :!~/git/lecture/compile_tex.sh %:r <Cr>

" Toggle Goya
nnoremap <Leader>r :Goyo<CR> 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comma separated mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easy motion map
imap ,w <C-o><leader><leader>w
imap ,b <C-o><leader><leader>b
imap ,s <C-o><leader><leader>s

imap ,p <C-x><C-p>
imap ,l <C-x><C-l>

imap ,x <Esc>:w<Cr>i
imap ,q <Esc>:x<Cr>


" Default title case key bindings conflict with tab control
let g:titlecase_map_keys = 0
nmap <leader>gt <Plug>Titlecase
vmap <leader>gt <Plug>Titlecase
nmap <leader>gT <Plug>TitlecaseLine

" Custom mappings
" ================
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation
map <Leader>a ggVG  " select all


" for presentation in Vim
nmap <Leader>s :PresentingStart <CR>


" navigation and split"
nnoremap <leader>s <C-w>s
nnoremap <leader>v <C-w>v
" nnoremap <leader>h <C-w>h
" nnoremap <leader>j <C-w>j
" nnoremap <leader>k <C-w>k
" nnoremap <leader>l <C-w>l

"Undotree""
nnoremap <leader>u :UndotreeToggle<cr>




