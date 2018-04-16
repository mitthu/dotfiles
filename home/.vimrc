" Auto install plugins
" Pathogen
" --------
" execute pathogen#infect()
"
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" Function: source a file if it exists
function! SourceIfExists(name)
	if filereadable(glob(a:name))
		exec 'source '.a:name
	endif
endfunction

" Function: add code header based on lang
function! CodeHeader(lang)
    let l:output = system("code_header " . a:lang)
    let l:output = substitute(l:output, '[\r\n]*$', '', '')
    execute 'normal i' . l:output
endfunction

" Function: indent using tabs
function! IndentWithTab()
	set softtabstop=4 " #columns vim uses for tab
	set shiftwidth=4  " #spaces to use for autoindenting
	set noexpandtab   " indent using tab
endfunction

" Function: indent using spaces
function! IndentWithSpace()
	set softtabstop=2 " #columns vim uses for tab
	set shiftwidth=2  " #spaces to use for autoindenting
	set expandtab     " indent using space
endfunction

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'

" Load the plugins, as if the file exists.
call SourceIfExists("~/.vim/rc/vundle-general.vim")
call SourceIfExists("~/.vim/rc/vundle-developer.vim")
call SourceIfExists("~/.vim/rc/vundle-experimental.vim")

" All the Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" --------------------------------------------------------------
" My Config...
" --------------------------------------------------------------
set shell=bash    " Syntastic (vim's syntax checker) doesn't play
                  " nice with the fish shell.
set whichwrap+=<,>,h,l,[,] " Wrap cursor against line boundaries
set number
set tabstop=4
set noexpandtab   " never uses spaces instead of tab characters
set softtabstop=4 " How many columns vim uses for tab. Tabs
                  " are given priority, and vim adjusts tabs
                  " and spaces to get the desired number of
                  " columns.
set autoindent
set copyindent
set shiftwidth=4  " number of spaces to use for autoindenting
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set mouse=a
set pastetoggle=<F2>
filetype on

" Set directory for storing backup (*~) and swap (*.swp) files
set backupdir=/tmp
set directory=/tmp

" Remappings
nnoremap ; :

filetype plugin indent on
if has('autocmd')
	autocmd filetype python set expandtab
endif

" Restore coursor position on file re-open
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

if &t_Co >= 256 || has("gui_running")
	" colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
	" switch syntax highlighting on, when the terminal has colors
	syntax on
endif

" Mouse related features
fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

" Auto-reload .vimrc when its modified
" Source: http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Macros
" ------
"  Surround word by braces
let @b='i(ea)'

" Setting the leader for mapped commands
let mapleader = ","

" Variables
" ---------
"  For plugin: Rip-Rip/clang_complete
let g:clang_library_path='/usr/lib/llvm-3.8/lib'
let g:clang_library_path='/usr/lib/llvm-3.8/lib/libclang.so.1'

" Bindings
" --------
" Insert Date-Time (in insert mode)
imap <c-d> <ESC>:exec 'normal a'.substitute(system("date +'%d-%b-%Y, %I:%M %P %Z'"),"[\n]*$","","")<CR>a
imap <c-c><c-b> <ESC>:call CodeHeader("bash")<CR>a
imap <c-c><c-c> <ESC>:call CodeHeader("c")<CR>a
imap <c-c><c-j> <ESC>:call CodeHeader("java")<CR>a

" Toggle to upper case
imap <c-u> <ESC>gUiwi
" Toggle to lower case
imap <c-l> <ESC>guiwi

" Open current file in split view
nnoremap <leader>h :split %<cr>
nnoremap <leader>v :vsplit %<cr>

" Switch spaces
nnoremap <leader>s :call IndentWithSpace()<cr>
nnoremap <leader>t :call IndentWithTab()<cr>

" Resource vimrc
nmap <silent> <leader><c-r> :so $MYVIMRC<CR>:echo 'Source => ' . $MYVIMRC <CR>
" Edit vimrc
nmap <silent> <leader><c-e> :e $MYVIMRC<CR>

" Lang specific actions
autocmd FileType yaml		call IndentWithSpace()
autocmd FileType ruby		call IndentWithSpace()
