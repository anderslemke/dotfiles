scriptencoding utf-8
set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'kchmck/vim-coffee-script'
Plug 'mileszs/ack.vim'
Plug 'chase/vim-ansible-yaml'
Plug 'elzr/vim-json'
Plug 'groenewege/vim-less'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'
Plug 'nanotech/jellybeans.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/gist-vim'
Plug 'Shougo/neomru.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/unite.vim'
Plug 'bling/vim-airline'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/L9'
Plug 'terryma/vim-multiple-cursors'
Plug 'sickill/vim-pasta'
Plug 'thoughtbot/vim-rspec'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'evanmiller/nginx-vim-syntax'
Plug 'vim-scripts/closetag.vim'
Plug 'leafgarland/typescript-vim'
Plug 'keith/rspec.vim'

call plug#end()

:set colorcolumn=80

syntax enable
filetype plugin indent on

let g:ack_default_options = " -H --nocolor --nogroup --column --type-add css=.sass,.scss --ignore-dir=node_modules --ignore-dir=node_shrinkwrap --ignore-dir=cordova --ignore-dir=ios --ignore-dir=android --ignore-dir=tmp --ignore-dir=vendor --ignore-dir=log --ignore-dir=public --ignore-dir=coverage --ignore=webpack-stats.json"
if executable('ag')
  let g:ackprg = 'ag --vimgrep --ignore-dir=node_modules --ignore-dir=node_shrinkwrap --ignore-dir=cordova --ignore-dir=ios --ignore-dir=android --ignore-dir=tmp --ignore-dir=vendor --ignore-dir=log --ignore-dir=public --ignore-dir=coverage --ignore=webpack-stats.json'
endif

let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|node_shrinkwrap|ios|android)$'
nmap ; :CtrlPBuffer<CR>

let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#whitespace#enabled=0

set shm=aoOti
set laststatus=2 " Always show the statusline

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

let mapleader=','
let g:ragtag_global_maps=1

" Gist stuff
let g:gist_post_private = 1
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set backupcopy=yes

set softtabstop=2 shiftwidth=2 expandtab
set tabstop=2
set scrolloff=3

" Search stuff
set ignorecase
set smartcase
set incsearch
set hlsearch " highlight results
nmap <leader><cr> :nohl<cr>

set pastetoggle=<F2>
set number
set listchars=nbsp:¬,tab:»·,trail:· " invisible chars
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
set foldmethod=manual
set foldlevelstart=99
map <leader>1 :set foldmethod=syntax foldlevel=1<CR>
map <leader>2 :set foldmethod=syntax foldlevel=2<CR>
map <leader>3 :set foldmethod=syntax foldlevel=3<CR>
map <leader>4 :set foldmethod=syntax foldlevel=4<CR>
map <leader>5 :set foldlevel=5<CR>
map <leader>6 :set foldlevel=6<CR>
map <leader>7 :set foldlevel=7<CR>
map <leader>8 :set foldlevel=8<CR>
map <leader>9 :set foldlevel=9<CR>
map <leader>0 :set foldlevel=99<CR>
nmap <space> :set foldmethod=syntax<CR>za
nmap <leader><space> :set foldmethod=manual foldlevel=99<CR>

" Recommended Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
nmap <Leader>e :Errors<CR>

" Pane navigation
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

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

nmap <c-f> :Ack! 
" Too bad you can't map <C-7>

" Pane splitting
nnoremap <Leader>h :sp<CR>
nnoremap <Leader>s :vsp<CR>
nnoremap <Leader>v :vsp<CR>

nnoremap <Leader>r :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

set path+=$PWD/src
set path+=$PWD/app
set path+=$PWD/src/redux
set path+=$PWD/spec/cassettes
set suffixesadd=.yml

" Stuff to ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

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

" vim-rspec
map <Leader>T :call RunCurrentSpecFile()<CR>
map <Leader>t :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch zeus test {spec}"

" vim-dispatch
map <Leader>d :Dispatch<CR>

" Use ctrl + s to save
noremap <C-S> :wa<CR>
vnoremap <C-S> <C-C>:wa<CR><Esc>
inoremap <C-S> <C-O>:wa<CR><Esc>

" Use ctrl + q to close
noremap <silent> <C-Q> :q<CR>

" JSX
let g:jsx_ext_required = 0 " Do not require .jsx

set background=dark
colorscheme solarized
