scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'mileszs/ack.vim'
Plug 'anderslemke/snipmate.vim'
Plug 'chase/vim-ansible-yaml'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'kien/ctrlp.vim'
Plug 'mattn/gist-vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'rstacruz/sparkup'
Plug 'Shougo/unite.vim'
Plug 'bling/vim-airline'
Plug 'kchmck/vim-coffee-script'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/L9'
Plug 'terryma/vim-multiple-cursors'
Plug 'sickill/vim-pasta'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'mattn/webapi-vim'
Plug 'anderslemke/vim-rubytest'
Plug 'benmills/vimux'
Plug 'thoughtbot/vim-rspec'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'vim-scripts/closetag.vim'

call plug#end()

syntax enable
filetype plugin indent on
set background=dark
colorscheme solarized

let g:ack_default_options = " -H --nocolor --nogroup --column --type-add css=.sass,.scss --ignore-dir=node_modules --ignore-dir=tmp --ignore-dir=vendor --ignore-dir=public"

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled=0

set shm=aoOti
set laststatus=2 " Always show the statusline

let mapleader=','
let g:ragtag_global_maps=1

" Gist stuff
let g:gist_post_private = 1
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

set backupcopy=yes

set softtabstop=2 shiftwidth=2 expandtab
set tabstop=2
set scrolloff=3

" Search stuff
set ignorecase
set smartcase
set incsearch
set hlsearch " highlight results
nmap <cr> :nohl<cr>

set pastetoggle=<F2>
set number
set listchars=tab:»·,trail:· " invisible chars
set list
set backspace=indent,eol,start " Allow backspace to delete everything

set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
if exists("+undofile")
  set undofile
  set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
endif

set ai
set foldmethod=syntax
set foldlevelstart=99
map <leader>1 :set foldlevel=1<CR>
map <leader>2 :set foldlevel=2<CR>
map <leader>3 :set foldlevel=3<CR>
map <leader>4 :set foldlevel=4<CR>
map <leader>5 :set foldlevel=5<CR>
map <leader>0 :set foldlevel=99<CR>
nmap <space> za

" Recommended Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nmap <Leader>e :Errors<CR>

" Pane navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Move up/down wrapped lines
:nmap j gj
:nmap k gk

" Unimpaired new bindings
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

" Open previous file
nmap <leader>p <c-^>

nmap <c-f> :Ack 
" Too bad you can't map <C-7>

" Pane splitting
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>s :vsp<CR>
nnoremap <Leader>h :sp<CR>

nnoremap <Leader>r :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

" Stuff to ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn)$'
nmap ; :CtrlPBuffer<CR>

if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

" Those annoying standard things
:command! WQ wq
:command! Wq wq
:command! Wa wa
:command! WA wa
:command! W w
:command! Q q

" Use Spring for vim-rubytest
let g:rubytest_cmd_test = "clear;spring testunit %p --use-color"
let g:rubytest_cmd_testcase = 'clear;spring testunit %p -n "%c" --use-color'
let g:rubytest_in_vimux = 1
"let g:rubytest_in_quickfix = 1

" vim-rspec
map <Leader>sT :call RunCurrentSpecFile()<CR>
map <Leader>st :call RunNearestSpec()<CR>
map <Leader>sl :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch 'be rspec {spec}'"

" jest
map <Leader>j :VimuxRunCommand 'clear;jest'<CR>
map <Leader>d :Dispatch<CR>

map <Leader>ss :call system('spring stop')<CR>

" Vimux default orientation
let g:VimuxOrientation = "h"
let g:VimuxHeight = "25"

" Use ctrl + s to save
noremap <C-S> :wa<CR>
vnoremap <C-S> <C-C>:wa<CR><Esc>
inoremap <C-S> <C-O>:wa<CR><Esc>

" Use ctrl + q to close
noremap <silent> <C-Q> :q<CR>
