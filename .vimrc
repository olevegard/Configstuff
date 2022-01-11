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
Plugin 'udalov/kotlin-vim'
Plugin 'duckwork/nirvana'
Plugin 'junk-e/identity'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'WolfgangMehner/git-support'
Plugin 'preservim/nerdtree' |
            \ Plugin 'PhilRunninger/nerdtree-buffer-ops'
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
"" YCM populate lest of errors so we can jump between them
let g:ycm_always_populate_location_list = 1

" Enable YCM support for other languages 
" For flutter 2_5_3
 let g:ycm_language_server =
 \ [
 \   {
 \     'name': 'dart',
 \     'cmdline': [ '/home/olevegard-work/Programming/dart_2_15_1/bin/dart', "/home/olevegard-work/Programming/dart_2_15_1/bin/snapshots/analysis_server.dart.snapshot", '--lsp' ],
 \     'filetypes': [ 'dart' ]
 \   },
 \   {
 \     'name': 'kotlin',
 \     'cmdline': [ '/home/olevegard-work/Programming/kotlin-lsp/server/bin/kotlin-language-server' ],
 \     'filetypes': [ 'kotlin' ]
 \   }
 \ ]
 " 

" For flutter 1_22_6
 " let g:ycm_language_server =
 " \ [
 " \   {
 " \     'name': 'dart',
 " \     'cmdline': [ '/home/olevegard-work/Programming/dart_1_10_5/bin/dart', "/home/olevegard-work/Programming/dart_1_10_5/bin/snapshots/analysis_server.dart.snapshot", '--lsp' ],
 " \     'filetypes': [ 'dart' ]
 " \   }
 " \ ]




"  \      'cmdline': [ 'dart', "/home/olevegard-work/Programming/dart-sdk/bin/snapshots/dartanalyzer.dart.snapshot", '--lsp' ],

"let g:ycm_language_server =
" \ [
" \   {
" \     'name': 'dart',
" \     'cmdline': [ 'dart', "/home/olevegard-work/Programming/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", '--lsp' ],
" \    'filetypes': [ 'dart' ]
" \   }
" \ ]



" Put your non-Plugin stuff after this line
" Remaps
" <leader> = '\'

" Use tk/tj to jump to between buffers
nnoremap tk :bp<CR>
nnoremap tj :bn<CR>

" Use \opn to open path in new buffer
nnoremap <leader>opn :wincmd F <CR> <bar> :wincmd L <CR>

" YCM hotkeys
" Goto definition in the same buffer ( vertical )
nnoremap <leader>jds :YcmCompleter GoToDefinition<CR>

" Goto definition but in a new buffer ( vertical )
nnoremap <leader>jdn :vert sb <bar> :YcmCompleter GoToDefinition<CR>
nnoremap <leader>res :YcmRestartServer<CR>
nnoremap <leader>fix :YcmCompleter FixIt<CR>
nnoremap <leader>ren :YcmCompleter RefactorRename<CR>

nnoremap <leader>ref :YcmCompleter GoToReferences<CR>

" Jump between errors
nnoremap <leader>ne :lnext<CR>
nnoremap <leader>pe :lprevious<CR>

" Go
nnoremap <leader>gfmt :w!<CR> :! go fmt %<CR>
nnoremap <leader>gbd :! go build %<CR>
nnoremap <leader>gor :! go run %<CR>

" Dart
nnoremap <leader>dfmt :w!<CR> :! flutter format --line-length 100 % <CR>
nnoremap <leader>dtest :! flutter test % <CR>
nnoremap <leader>dtall :! flutter test <CR>
nnoremap <leader>pget :! flutter pub get <CR>
nnoremap <leader>prun :! flutter pub run build_runner build --delete-conflicting-outputs  <CR>
nnoremap <leader>json :! dart lib/localization/json_to_dart.dart <CR>

" Flutter analyze all
nnoremap <leader>anala :! flutter analyze <CR>
" Flutter analyze current dir
nnoremap <leader>anald :! flutter analyze "$(dirname %)" <CR>
" Flutter analyze current file
nnoremap <leader>analf :! flutter analyze "$(dirname %)" \| grep "$(basename %)" <CR>
nnoremap <leader>frun :! flutter run  <CR>

" Git
nnoremap <leader>gdi : GitDiff %  <CR>
nnoremap <leader>gsa : GitStatus <CR>

" Tree view
nnoremap <leader>nt : NERDTree <CR>

" Make GitDiff show diff for current file only
" let g:Git_DiffExpandEmpty = 'yes'



" Autosave when buffer changes
autocmd TextChanged,TextChangedI <buffer> silent write

autocmd User YcmQuickFixOpened <buffer> silent write
" ,

filetype plugin indent on
"filetype plugin on
" allow backspacing over everything in insert mode:
set splitright
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

set number relativenumber


" Key bindings
" Enter to insert empty line under.
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
