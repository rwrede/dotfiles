syntax on
filetype off           " Enable filetype detection

set nocompatible  " Surprise, I actually want Vim :-)

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" let Vundle manage Vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-cucumber' # comment again in when PR accepted
Plugin 'rwrede/vim-cucumber'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-dispatch'
Plugin 'jgdavey/vim-blockle'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'thoughtbot/vim-rspec'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'kana/vim-textobj-user'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'heartsentwined/vim-emblem'
Plugin 'jpo/vim-railscasts-theme'
Plugin 'majutsushi/tagbar'
" Plugin 'jiangmiao/auto-pairs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ngmy/vim-rubocop'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdcommenter'
Plugin 'shime/vim-livedown'
Plugin 'nelstrom/vim-markdown-folding'
Plugin 'jreybert/vimagit'
Plugin 'scrooloose/syntastic'
call vundle#end()

let g:airline_theme='bubblegum'

let g:syntastic_javascript_checkers = ['eslint']
" Override eslint with local version where necessary.
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
endif

" default setting for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" When set to 1 the error window will be automatically opened when errors are
" detected, and closed when none are detected.
let g:syntastic_auto_loc_list=1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
nmap <silent> <leader>c :SyntasticCheck<cr>

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

" Change cursor shape in insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set laststatus=2 " always show status bar
set showcmd      " display incomplete commands

set incsearch    " do incremental searching
set hlsearch     " show my search results
set ignorecase   " Ignore case when searching
set smartcase    " Ignore case when searching lowercase

set lbr          " long lines are wrapped on word boundaries
set wrap
set textwidth=120
set formatoptions=qrn1
set colorcolumn=120 " show a red line in column 120

" Time to wait after ESC (default causes an annoying delay)
set timeout timeoutlen=1000 ttimeoutlen=100

" Spaces not Tabs.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8   " Unicode is a beast, but...

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

" Comment in if the binary is called ack-grep instead of ack on your maching
" This is the case on staging server of course.
" let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Settings for NERDTree
let NERDChristmasTree=1   " Colorful output!!1!
let NERDTreeChDirMode=2   " Always cd to the rootdir of the NERDTree
let NERDTreeHijackNetrw=1
let NERDTreeShowHidden=1

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
  " for vim-dispatch to work better
  autocmd FileType cucumber compiler cucumber | setl makeprg=zeus\ cucumber
  autocmd FileType ruby
        \ if expand('%') =~# '_test\.rb$' |
        \   compiler rubyunit | setl makeprg=testrb |
        \ elseif expand('%') =~# '_spec\.rb$' |
        \   compiler rspec | setl makeprg=zeus\ rspec |
        \ else |
        \   compiler ruby | setl makeprg=ruby\ -wc\ \"%:p\" |
        \ endif
  " Source the vimrc file after saving it
  autocmd BufWritePost .vimrc source $MYVIMRC
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

" show file explorer
" map <Leader>d :Explore<CR>

noremap <s-D-right> :tabnext<cr>
noremap <s-D-left> :tabprev<cr>

" resize current buffer by +/- 5
nnoremap <s-C-left> :vertical resize -5<cr>
nnoremap <s-C-right> :vertical resize +5<cr>

nnoremap <C-n> :tabnew<cr>

" for jumping between opening/ending keywords, e.g. class => end, if => end
" with %
if filereadable($VIMRUNTIME . "/macros/matchit.vim")
  source $VIMRUNTIME/macros/matchit.vim
endif

"show git branch in a statusline
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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
" set relativenumber
" " switch between absolute and relative number mode with crtl+n
" function! NumberToggle()
"   if(&relativenumber == 1)
"     set number
"   else
"     set relativenumber
"   endif
" endfunction
" nnoremap <C-n> :call NumberToggle()<cr>

" autocmd InsertEnter * :set number
" autocmd InsertLeave * :set relativenumber

" Quickly edit/reload the vimrc file by pressing the leader key (here ,) and
" ev/sv
nmap <silent> <leader>ev :e $MYVIMRC<cr>
nmap <silent> <leader>sv :so $MYVIMRC<cr>

" Never let vim write a backup file. We have version control right?
set nobackup
set noswapfile
" let vim save undofiles after closing
set undofile

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


"###### Leader key definitions ######
inoremap öö <ESC>

nnoremap <leader>. :CtrlPTag<cr>
nnoremap <leader>m :CtrlP<cr>
nnoremap <leader>t :TagbarToggle<cr>
" Go to tag definition under cursor
nnoremap <leader>g <C-]><cr>
" Go to next found tag definition in the list
nnoremap <leader>n :tn<cr>
" Go back in jump list with CTRL-O
" Go forward in jump list again with CTRL-TAB

" type ,w to vertical split the current file and move to new window
nnoremap <leader>v <C-w>v<C-w>l
" NERDtree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
nnoremap <leader>D :NERDTreeTabsToggle<cr>
let g:nerdtree_tabs_open_on_console_startup=1


" Press only ctrl+{h,j,k,l} to navigate through windows.
" Especially when mapping the caps lock key to ctrl this is very helpful.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Hide files matching patterns in netrw file explorer:
let g:netrw_list_hide=".*\.un~"

" Mark all scenarios as wip by typing :WIP
command! -range -nargs=0 WIP %s/^\( *\)Scenario/\1@wip\r\1Scenario/g

" Convert to new ruby 1.9 hash syntax
command! -range -nargs=0 HASH %s/:\([^ ]*\)\(\s*\)=>/\1:/g

let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']

" I want a black sign column for airblade/vim-gitgutter because it looks so
" nice!
highlight clear SignColumn
" I do not want gitgutter to update signs when I stop typing (improve perf)
let g:gitgutter_realtime = 0
" I do not want gitgutter to update signs when I switch buffers, tabs or focus
" the GUI (improve perf)
let g:gitgutter_eager = 1

let g:gist_post_private = 1

" remap split join commands to make them easier to type (AndrewRadev/splitjoin.vim)
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" project wide search and replace
" :args `ag -l x .`
" :argdo %s/x/y/gec | w

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

autocmd FileType ruby nmap <buffer> <D-m> <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <D-m> <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <D-m> <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <D-r> <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <D-r> <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <D-r> <Plug>(xmpfilter-run)

set clipboard=unnamed

" Tabs
:hi TabLineFill ctermfg=Black ctermbg=Black
:hi TabLine ctermfg=White ctermbg=Black
:hi TabLineSel ctermfg=DarkBlue ctermbg=White
nnoremap gl  :tabnext<CR>
nnoremap gh  :tabprev<CR>
nnoremap g<Right>  :tabnext<CR>
nnoremap g<Left>  :tabprev<CR>

let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

set nofoldenable

nmap <Leader>q :quit<CR>
