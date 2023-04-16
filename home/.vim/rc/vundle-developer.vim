" Contains plugins which are useful for coding.
" Date of Creation: 20-Aug-2014, 9:49 am IST

" Code Completions
" ----------------
" Contains vundle plugins
" Code completion
"Bundle 'Valloric/YouCompleteMe'

" Java autocomplete: This is javacomplete, an omni-completion script of JAVA
" language for vim 7.
" Source: http://www.vim.org/scripts/script.php?script_id=1785
"Bundle 'javacomplete'

" C/C++/Objective-C/Objective-C++ auto-complete.
" Source: http://www.vim.org/scripts/script.php?script_id=3302
"         http://github.com/Rip-Rip/clang_complete
" Needed:
" Path to directory where library can be found
"	let g:clang_library_path='/usr/lib/llvm-3.8/lib'
"
" Install:
" exuberant-ctags (ubuntu)
"Bundle 'Rip-Rip/clang_complete'

" Language Server Protocol & auto-complete
" https://github.com/prabirshrestha/vim-lsp
Bundle 'prabirshrestha/vim-lsp'
Bundle 'prabirshrestha/asyncomplete.vim'
Bundle 'prabirshrestha/asyncomplete-lsp.vim'

" Install language specific server
" https://github.com/mattn/vim-lsp-settings
" Open a file and run :LspInstallServer
Bundle 'mattn/vim-lsp-settings'

