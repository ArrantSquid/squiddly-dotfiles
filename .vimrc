" Neumann's .vimrc file

" ==================================================
" Starting Up Settings
" ==================================================
set nocompatible            " Do not try and be VI compatible

" ==================================================
" Vundle Setup
" ==================================================
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ==================================================
" Vundle Plugin Management
" ==================================================
Plugin 'vim-scripts/TaskList.vim'
Plugin 'corntrace/bufexplorer'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'xolox/vim-misc'
Plugin 'tarmack/vim-python-ftplugin'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-repeat'
Plugin 'derekwyatt/vim-scala'
Plugin 'xolox/vim-session'
Plugin 'tpope/vim-surround'
Plugin 'honza/vim-snippets'

call vundle#end()           " required

" Must be called after all vundle stuff
syntax on
filetype on
filetype plugin indent on

" ==================================================
" View/Color Settings
" ==================================================
colorscheme molokai
let g:rehash256 = 1

" ==================================================
" Basic Settings
" ==================================================
set ch=1				    " Make command line one line high
set scrolloff=3				" Keep 3 lines when scrolling
set autoindent				" Always set autoindenting on
set visualbell t_vb=		" Turn off error beep/flash
set novisualbell			" Turn off visual bell
set number				    " Show line numbers
set title				    " Show title in console title bar
set nostartofline			" Don't jump to first character when paging
set backspace=2				" Start,indent,eol
set matchpairs+=<:>			" Show matching <> (html mainly) as well
set showmatch           	" Jump to matching brace immediately after insert
set matchtime=3				" Time vim will sit on the matching brace
set nosmartindent 			" Set smartindent on
set expandtab
set dictionary+=/usr/share/dict/words 	" Path to dictionary for vim to use in completion
set shortmess=atI			" Abbreviate messages
set hlsearch				" Highlight search items
set wildmenu				" Tab complete commands
set complete+=s				" Complete from a Thesaurus if possible
set wildmode=list:longest,full 		" List longest first. Don't know if I want this
set wildignore+=*.pyc       		" Whoever wanted to modify a .pyc?
set history=10000			" Give me lots of Undos
set tabpagemax=50			" I want to be able to open entire directories into tabs
set virtualedit=all			" Let my cursor go everywhere
set incsearch				" Search as I type
set shellslash 				" Use the / instead of \
set nowrap				    " No word wrap
set viminfo='100,/100,:100,@100 	" Settings for vim to remember stuff on startup :help viminfo
set laststatus=2			" Always show status line
" Harder to explain but an awesome statusline
" %r tells if the file is readonly
" %{expand('%:p')} gives the full path to the file
" %l/%L current line and total lines
" %v current column
set statusline=%r\ F:%{expand('%:p')}\ L:%l/%L\ C:%v
set hidden 				    " This allows vim to work with buffers much more liberally. So no warnings when switching modified buffers
set sessionoptions=buffers,resize,winpos,winsize " What information to save when creating a session.
set sts=4                   " Set the softtabstop to 4 for everything
set ts=4 				    " Set the tabstop to 4 for everything
set sw=4 				    " Set the shiftwidth to 4 for everything
let g:session_autosave = 'no'       " Don't <expletive> ask me to save a <expletive> session every <expletive> time
let g:session_autoload = 'no'       " Don't <expletive> ask me to open a <expletive> file every <expletive> time
set nofoldenable            " Set the folds to disabled by default

" Persistent undo
set undodir=~/.vim_undo//
set undofile

" Put all of the swap files in one directory
set directory=~/.vim_swap//

" ==================================================
" Set Snippet Options
" ==================================================
" Set the snippet directories
let g:UltiSnipsSnippetDirectories=["bundle/vim-snippets/UltiSnips", "my_snippets"]

" Set my name as the author
let g:snips_author = 'ArrantSquid'
" Set the docstrings to be normal, doxygen or sphinx based
let g:ultisnips_python_style = 'sphinx'             " sphinx style docstrings
" Move through snippets with the following
let g:UltiSnipsJumpForwardTrigger = '<tab>'         " tab goes forward
let g:UltiSnipsJumpBackwardTrigger = '<S-tab>'      " shift tab goes backwards

" ==================================================
" Set NERDTree Options
" ==================================================
let NERDTreeIgnore = ['\.pyc$']

" ==================================================
" Set TaskList Options
" ==================================================
" Set the tags we want to look for when populating our todo
let g:tlTokenList = ['FIXME', 'TODO', 'XXX', 'fixme', 'todo', 'xxx']

" ==================================================
" Set Filetype/GUI Options
" ==================================================
 if has("autocmd")

    " Use .as for ActionScript files, not Atlas files.
    autocmd BufNewFile,BufRead *.as set filetype=actionscript

    " Remove line/column selection on inactive panes
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    autocmd WinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorcolumn

    " Automatically delete trailing white spaces
    autocmd BufEnter,BufRead,BufWrite * silent! %s/[\r \t]\+$//
    autocmd BufEnter *.php :%s/[ \t\r]\+$//e
    " Set current directory to that of the opened files
    autocmd BufEnter,BufWrite * lcd %:p:h
    " Set default textwidth
    autocmd BufEnter * let b:textwidth=80

    " If a MayaAscii file hightlight as if a mel file
    autocmd BufRead,BufNewFile *.ma setf mel

    " Ensure that all my auto formating is minimal
    autocmd Filetype * setlocal formatoptions=t

    " Filetype specific tabbing
    autocmd FileType * setlocal ts=4 sts=4 sw=4 expandtab

    " Filetype specific comment leaders
     autocmd FileType * let b:comment_leader = ''
     autocmd FileType vim,vimrc let b:comment_leader = '" '
     autocmd FileType haskell,vhdl,ada let b:comment_leader = '-- '
     autocmd FileType actionscript,cs,javascript,c,cpp,java,mel,objc,objcpp let b:comment_leader = '// '
     autocmd FileType sh,make,python,tcsh,snippets,apache,conf,ruby let b:comment_leader = '# '
     autocmd FileType tex let b:comment_leader = '% '
     autocmd FileType htmldjango let b:comment_leader = '{%comment%} {%endcomment%} '
     autocmd FileType css let b:comment_leader = '/* */ '

     autocmd Filetype python let b:textwidth=79

    " Set the default file to be python
     autocmd BufEnter * if &filetype == "" | setlocal ft=python | endif

    " Set omnicomplete to not be a fucking dick!
    set completeopt=menu,menuone

    " Setup omnicomplete code completion
     autocmd FileType python set omnifunc=pythoncomplete#Complete
     autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
     autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
     autocmd FileType css set omnifunc=csscomplete#CompleteCSS
     autocmd FileType cs set omnifunc=cscomplete#CompleteCS

 endif

" ==================================================
" Key Mappings
" ==================================================
" Set our leader character
let mapleader=","

command! RunPythonBuffer call DoRunPythonBuffer()

" This allows for easy completion
inoremap <leader>, <C-x><C-o>

map <leader>p :RunPythonBuffer<CR>
map <leader>f :let @*=expand('%:p')<CR>:echom @*<CR>

" Match the lines that are too long.
nmap <leader>m :exec 'match WarningMsg /\%'.b:textwidth.'v.*/'<CR>
nmap <leader>n :match<CR>

" Shortcut to grab last inserted text
nmap gV `[v`]

" Turning off the stupid man pages thing
map K <Nop>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" This if for custom wrap toggle
nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

" Clear highlights with spacebar
nmap <silent> <Space> :nohlsearch <CR>

" Allow me to scroll horizontally
nmap <silent> <leader>o 30zl
nmap <silent> <leader>i 30zh

" Map to quickly open and reload my vimrc
map <leader>v :e $MYVIMRC<CR><C-W>_
map <silent> <leader>V :source $MYVIMRC<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Sometimes I don't want spelling
nmap <leader>s :setlocal spell! spelllang=en_gb<CR>

" New commenting and uncommenting procs
map <leader>c :call CommentLine()<CR>
map <leader>u :call UncommentLine()<CR>

" Toggle Tagbar
nmap <leader>o :TagbarToggle<CR>

" Toggle NERDTree
nmap <leader>nt :NERDTree<CR>

" Wrap a file
nmap <leader>w :set wrap<CR>
" Unwrap a file
nmap <leader>nw :set nowrap<CR>

" Open Session
nmap <leader>os :OpenSession<CR>
" Save Session
nmap <leader>ss :SaveSession

" Get the current filtype
nmap <leader>ft :set filetype?<CR>

" Django HTML Highlighting
nmap <leader>dh :setfiletype htmldjango<CR>

" Markdown Highlighting
nmap <leader>md :setfiletype markdown<CR>

" Replace shitty windows line endings
map <leader>fw :%s/<C-q><C-m>/\r/g<CR>

" Run unit tests on the current module
map <leader>b :! python pwd/../manage.py test

" ==================================================
" Plugin Settings
" ==================================================
"Additional python syntax highlighting
let python_highlight_all=1

" Gundo Plugin
nnoremap <F5> :GundoToggle<CR>

" TaskList Plugin
nnoremap T :TaskList<CR>

" ==================================================
" Functions
" ==================================================
