" ##################### initialize #############################
" disable file type connection once
filetype off
filetype plugin indent off

" dein begin
" dein auto install
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath

" plugin load and make cache
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.vim/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

" shortage plugin auto install
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
" dein end

" validation-mouse-click
if has("mouse") " Enable the use of the mouse in all modes
  set mouse=a
endif

syntax on


"End dein Scripts-------------------------
" ##################### set #############################

set synmaxcol=200

"fast-terminal-access
set ttyfast

" directory
set autochdir

set completeopt=menuone
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set smartcase
set number
set encoding=utf-8

set clipboard&
set clipboard^=unnamedplus

" activation inclement search
set incsearch

"highrightline current position
"set cursorline
"set cursorcolumn

" line number color
autocmd ColorScheme * highlight LineNr ctermfg=214

" statusline_set
set laststatus=2
set noshowmode

" colorscheme
set background=dark
colorscheme hybrid

" statusline_add
if !has('gui_running')
  " use 256-colors in the terminal
  set t_Co=256
endif

" for snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ##################### other #############################

" change ; : only normal mode
nnoremap ; :
nnoremap : ;

" Complement of the parenthesis
" inoremap { {}<Left>
" inoremap {<enter> {}<left><cr><esc><s-o>
" inoremap ( ()<esc>i
" inoremap (<enter> ()<left><cr><esc><s-o>
" inoremap ' ''<left>
" inoremap " ""<left>

" neosnippet
inoremap <expr><s-tab>  pumvisible() ? "\<c-p>" : "\<s-tab>"
imap <c-k> <plug>(neosnippet_expand_or_jump)
smap <c-k> <plug>(neosnippet_expand_or_jump)

" supertab like snippets behavior.
imap <expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<c-n>" : "\<tab>"
smap <expr><tab> neosnippet#jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"
imap <expr><tab> pumvisible() ? "\<c-n>" : neosnippet#jumpable() ? "\<plug>(neosnippet_expand_or_jump)" : "\<tab>"

" vim-indent-guides"
" auto-vim-indent-guides-on
let g:indent_guides_enable_on_vim_startup=1
" amount of indent that start of guide
let g:indent_guides_start_level=2
" auto-coloring-disable
let g:indent_guides_auto_colors=0
" color of the odd number indent
autocmd vimenter,colorscheme * :hi indentguidesodd ctermbg=235
" color of the even number indent
autocmd vimenter,colorscheme * :hi indentguideseven ctermbg=234
" width of the change of the highlighted color
let g:indent_guides_color_change_percent = 30
" width of guide
let g:indent_guides_guide_size = 1

" neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif

let g:neocomplete#keyword_patterns._ = '\h\w*'

" markdown
au BufRead,BufNewFile *.md, set filetype=markdown
au BufRead,BufNewFile *.MD, set filetype=markdown
le g:previm_open_cmd = 'open -a Firefox'

" python indent
autocmd filetype python setl autoindent
autocmd filetype python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd filetype python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" syntastic
let g:syntastic_mode_map = { 'mode': 'active' }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_check_on_wq=0
let g:syntastic_check_on_open=1

" dictionaly
function! s:DictionaryTranslate(word)
    let l:gene_path = '~/.vim/dict/gene.txt'
    let l:output_option = a:word =~? '^[a-z_]\+$' ? '-A 1' : '-B 1' " 和英 or 英和
    silent pedit Translate\ Result
    wincmd P
    %delete "
    setlocal buftype=nofile noswapfile modifiable
    silent execute 'read !grep -ihw' l:output_option a:word l:gene_path
    silent wincmd p
endfunction
command! -nargs=1 -complete=command DictionaryTranslate call <SID>DictionaryTranslate(<f-args>)

" Complement of html tag
augroup myxml
  autocmd!
  autocmd filetype xml inoremap <buffer> </ </<c-x><c-o>
  autocmd filetype html inoremap <buffer> </ </<c-x><c-o>
augroup end

" template html
autocmd bufnewfile *.html 0r $HOME/.vim/template/html.txt

" template python
autocmd bufnewfile *.py 0r $HOME/.vim/template/python.txt

" background is transparency
highlight Normal ctermbg=none

" enable file type connection
filetype plugin indent on
