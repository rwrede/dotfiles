syntax on
filetype off           " Enable filetype detection

set nocompatible  " Surprise, I actually want Vim :-)

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
Bundle 'gmarik/vundle'

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-rails'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'mileszs/ack.vim'
Bundle 'rking/ag.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-endwise'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-commentary'
" Bundle 'tpope/vim-cucumber' # comment again in when PR accepted
Bundle 'rwrede/vim-cucumber'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-dispatch'
" deactivated because of performance problems when saving files
" Bundle 'scrooloose/syntastic'
Bundle 'jgdavey/vim-blockle'
" Bundle 'ervandew/supertab'
" Bundle 'vim-scripts/AutoComplPop'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'thoughtbot/vim-rspec'
Bundle 'airblade/vim-gitgutter'
Bundle 'bling/vim-airline'
" Bundle 'mattn/gist-vim'
" Bundle 'skalnik/vim-vroom'
Bundle 'AndrewRadev/splitjoin.vim'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'mustache/vim-mustache-handlebars'

let g:EasyMotion_leader_key = '<space>'

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
filetype plugin indent on

" :help W11 reading in files automatically if only changed on disk
set autoread
set backspace=indent,eol,start
set scrolloff=5  " have always 5 lines of context around the cursor

set history=50   " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set cursorline
set laststatus=2 " always show status bar
set showcmd      " display incomplete commands

set incsearch    " do incremental searching
set hlsearch     " show my search results
set ignorecase   " Ignore case when searching
set smartcase    " Ignore case when searching lowercase

set lbr          " long lines are wrapped on word boundaries
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80 " show a red line in column 80

" Time to wait after ESC (default causes an annoying delay)
set timeout timeoutlen=1000 ttimeoutlen=100

" Spaces not Tabs.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8   " Unicode is a beast, but...
set undofile

" what to show
set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:»·    " trailing spaces and tabs are shown and eol not

set number         " show line-numbers
set wildmenu       " use funky wildmenu to display alternate findings

" windows, buffers, splits, ...
set winminheight=0

" Diffing
if &diff
  set diffopt=iwhite
  set wrap
else
endif

" STFU
set noerrorbells
set visualbell
set t_vb=" "

" Setting for Latexsuite
" use ack if available (credit: hukl)
if executable("ack")
else
  set grepprg=grep\ -nH\ $*
endif

" Settings for NERDTree
let NERDChristmasTree=1   " Colorful output!!1!
let NERDTreeChDirMode=2   " Always cd to the rootdir of the NERDTree
let NERDTreeHijackNetrw=1

" The OSX-keyboardlayout sucks, especially when you have \ as Leader...
" and this doesn't hurt on other OS either
let mapleader = ","
let maplocalleader = ","

" Vim should look good.
" so, at least use some dark theme
colo torte

" this translates to: TERM=xterm-256color (or mvim/gvim)
" or: use the more colorful colorscheme if possible
if &t_Co >= 256 || has('gui')
  colo railscasts
endif

" Tweak the GUI
if has('gui')
  set guioptions-=T               " no toolbar
  set guioptions-=m               " no menu

  if has('win32')
    set guifont=Lucida_Console:h10
  endif

  if has('gui_macvim')
    set fuoptions=maxhorz,maxvert  " Let Fullscreen be really fullscreen
    " set transparency=8             " Mac selling point #1? transparent windows! :-)
    set guifont=Menlo\ Regular:h12
  endif
endif

if has('windows')
  " Always show the Tabline
  " set showtabline=2

  " Only show the Tabline if needed
  set showtabline=1
endif

" Functions
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" autocommands
if has('autocmd')
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
  autocmd BufRead *.scss :setlocal fdm=indent
  autocmd BufRead *.md :setlocal noet
  autocmd BufRead .vimperatorrc :setlocal ft=vimperator
  autocmd BufRead *.yml :setlocal fdm=indent fdl=2 ai
endif

" Key-mappings
set pastetoggle=<F2>

" Key-mappings for plugins
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=>\?<CR>
  vmap <Leader>t= :Tabularize /=>\?<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" rails.vim
" map <F5> <ESC>:w:Rake

" NERDtree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" show file explorer
" map <Leader>d :Explore<CR>

nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W
noremap <s-D-right> :tabnext<cr>
noremap <s-D-left> :tabprev<cr>

" for jumping between opening/ending keywords, e.g. class => end, if => end
" with %
if filereadable($VIMRUNTIME . "/macros/matchit.vim")
  source $VIMRUNTIME/macros/matchit.vim
endif

"show git branch in a statusline
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" write all files when loosing focus
" au FocusLost * :wa
"
" Hides buffers instead of closing them. Means you can have unwritten files
" and open a new file without being forced to write or undo your changes.
" Could be very helpful but does not work fine with the on FocusLost :wa
" setting above as you will get errors for [new] unsaved files. So experiment
" with the one setting or the other. Error: No file name for buffer X
set hidden

" relativenumber changes Vim’s line number column to display how far away each line is from
" the current one, instead of showing the absolute line number. Means easier
" user for motion commands like d<NUMBER>d
set relativenumber
" switch between absolute and relative number mode with crtl+n
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunction
nnoremap <C-n> :call NumberToggle()<cr>

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Quickly edit/reload the vimrc file by pressing the leader key (here ,) and
" ev/sv
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Never let vim write a backup file. We have version control right?
set nobackup
set noswapfile

" deactivate the arrow keys and force yourself to use hjkl
" nnoremap <up> <nop>
" nnoremap <down> <nop>
" nnoremap <left> <nop>
" nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
" nnoremap j gj
" nnoremap k gk

nnoremap <leader>a :Ack
inoremap öö <ESC>

" type ,w to vertical split the current file and move to new window
nnoremap <leader>w <C-w>v<C-w>l

" Press only ctrl+{h,j,k,l} to navigate through windows.
" Especially when mapping the caps lock key to ctrl this is very helpful.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" When set to 1 the error window will be automatically opened when errors are
" detected, and closed when none are detected.
let g:syntastic_auto_loc_list=1

" Hide files matching patterns in netrw file explorer:
let g:netrw_list_hide=".*\.un~"

" Mark all scenarios as wip by typing :WIP
command! -range -nargs=0 WIP %s/^\( *\)Scenario/\1@wip\r\1Scenario/g

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
