set nocompatible
filetype plugin indent on
"filetype plugin on
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set nobackup        " DON'T keep a backup file

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

let g:pymode_lint_ignore="E501,E731"

let g:pymode_folding = 0

set noswapfile

set history=50        " keep 50 lines of command line history
set ruler            " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch        " do incremental searching
set tabstop=4

set number                " line numbers
set cindent
set autoindent
set mouse=a                " use mouse in xterm to scroll
set scrolloff=5         " 5 lines bevore and after the current line when scrolling

set hid                 " allow switching buffers, which have unsaved changes
set tabstop=4
set shiftwidth=4        " 4 characters for indenting
set expandtab
set showmatch            " showmatch: Show the matching bracket for the last ')'?

set nowrap                " don't wrap by default
syn on
set completeopt=menu,longest,preview
set confirm

" setglobal spell spelllang=en_us
" setlocal spell spelllang=en_us

" set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" imap jj            <Esc>

colorscheme blue

" Disable sound
set noeb vb t_vb=

" Search
set incsearch
set hlsearch
set ignorecase smartcase " Make searches case-sensitive only if they contatin upper-case letters

" Make backspace work properly
" set backspace=indent,eol,start
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Always center cursor
set scrolloff=100

" Key bindings

" Enter to insert empy line under.
" <-Enter> O<Esc> "Does not work, KEY+Enter is interperated as Enter
nmap <CR> o<Esc>

" Copy using Ctrl + c, Ctrl + x and paste using Ctrl + p
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

vmap <C-h> :%y+

"Make mouse act like in terminal ( command line mode )
set mouse=c

" Set options
set guioptions-=m "remove menu bar
set guioptions-=T "remove toolbar
set guioptions-=r "remove right-hand scroll bar
set guioptions-=L "remove left-hand scroll bar

set guifont=consolas:h22:cDEFAULT

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
