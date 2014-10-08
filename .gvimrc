" Neumann's .gvimrc file
" ==================================================
" View/Color Settings
" ==================================================
if has("gui_macvim")
    set lines=75
    set columns=205
elseif has("win32")
    if has("autocmd")
        au GUIEnter * simalt ~x
    endif
endif
set mousehide
set keymodel=
set synmaxcol=200
colorscheme molokai
set guifont=Source\ Code\ Pro\ Light:h15
set cul
set cuc

set guioptions+=T                   " Show our toolbar
