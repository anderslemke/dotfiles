call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-vividchalk'
Plug 'nanotech/jellybeans.vim'
Plug 'rking/ag.vim'
Plug 'mileszs/ack.vim'
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
Plug 'tpope/vim-vinegar'
Plug 'pangloss/vim-javascript'
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

call plug#end()

syntax enable
filetype plugin indent on
set background=dark
colorscheme solarized

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

set foldmethod=syntax
set foldlevelstart=99
nmap <space> za

" Pane navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

" Open previous file
nmap <leader>p <c-^>

nmap <c-f> :Ag 

" Pane splitting
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>s :vsp<CR>
nnoremap <Leader>h :sp<CR>

nnoremap <Leader>r :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

" Stuff to ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/](vendor|\.git|\.hg|\.svn)$'

:command WQ wq
:command Wq wq
:command Wa wa
:command WA wa
:command W w
:command Q q

autocmd QuickFixCmdPost *grep* cwindow " To make VIM open a quickfix window after grep

" Use Spring for vim-rubytest
let g:rubytest_cmd_test = "clear;spring testunit %p --use-color"
let g:rubytest_cmd_testcase = 'clear;spring testunit %p -n "%c" --use-color'
let g:rubytest_in_vimux = 1

" vim-rspec
map <Leader>R :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>
"let g:rspec_command = "Dispatch rspec {spec}"
let g:rspec_command = "VimuxRunCommand 'spring rspec {spec}'"

" Vimux default orientation
let g:VimuxOrientation = "h"
let g:VimuxHeight = "25"
