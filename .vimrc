set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'duckwork/nirvana'
Plugin 'junk-e/identity'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'dart-lang/dart-vim-plugin'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"
nnoremap <leader>pb :b# <CR>

nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>res :YcmRestartServer<CR>
nnoremap <leader>fix :YcmCompleter FixIt<CR>

" Jump between errors
nnoremap <leader>ne :lnext<CR>
nnoremap <leader>pe :lprevious<CR>

" Go
nnoremap <leader>gfmt :w!<CR> :! go fmt %<CR>
nnoremap <leader>gbd :! go build %<CR>
nnoremap <leader>gor :! go run %<CR>

" Dart
nnoremap <leader>dfmt :w!<CR> :! flutter format --line-length 120 % <CR>
nnoremap <leader>dtest :! flutter test % <CR>
nnoremap <leader>dtall :! flutter test <CR>
nnoremap <leader>pget :! flutter pub get <CR>
nnoremap <leader>prun :! flutter pub run build_runner build --delete-conflicting-outputs <CR>
nnoremap <leader>json :! dart lib/localization/json_to_dart.dart <CR>
nnoremap <leader>anal :! flutter analyze <CR>
nnoremap <leader>frun :! flutter run  <CR>


" YCM populate lest of errors so we can jump between them
let g:ycm_always_populate_location_list = 1

let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'dart',
  \     'cmdline': [ 'dart', "/home/olevegard-work/Programming/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", '--lsp' ],
  \    'filetypes': [ 'dart' ]
  \   }
  \ ]

filetype plugin indent on
"filetype plugin on
" allow backspacing over everything in insert mode:
set spell
set spell spelllang=en_us,nb
set spell spellfile="/home/olevegard-work/Programming/min_fotball/spelling/*"
set backspace=indent,eol,start
set nobackup        " DON'T keep a backup file
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
let g:pymode_lint_ignore="E501,E731"
let g:pymode_folding = 0
set autoread " automatically reload
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
colorscheme jellybeans
" Disable sound
set noeb vb t_vb=
" Search
set incsearch
set hlsearch
set ignorecase smartcase " Make searches case-sensitive only if they containing upper-case letters
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
map <leader>b "_
