" Auto install plugins
" Pathogen
" --------
" execute pathogen#infect()
"
" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" Function: source a file if it exists
function SourceIfExists(name)
	if filereadable(glob(a:name))
		exec 'source '.a:name
	endif
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
set whichwrap+=<,>,h,l,[,] " Wrap cursor against line boundaries
set number
set tabstop=2
set autoindent
set copyindent
set shiftwidth=2  " number of spaces to use for autoindenting
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
