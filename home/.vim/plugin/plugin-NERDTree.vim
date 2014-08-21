" Source: https://github.com/scrooloose/nerdtree
" Date of Creation: 20-Aug-2014, 10:50 am IST

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" Close vim if conly NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
