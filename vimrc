execute pathogen#infect()
syntax on
filetype plugin indent on

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

set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
if exists("+undofile")
  set undofile
  set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
endif

nmap <space> za

" Pane navigation
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

nnoremap <Leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1

" Open recent file
nmap <leader><leader> <c-^>

" Pane splitting
nnoremap <Leader>v :vsp<CR>
nnoremap <Leader>s :vsp<CR>
nnoremap <Leader>h :sp<CR>

nnoremap <Leader>r :Unite -buffer-name=recent -winheight=10 file_mru<cr>
nnoremap <Leader>b :Unite -buffer-name=buffers -winheight=10 buffer<cr>

" Stuff to ignore
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

:command WQ wq
:command Wq wq
:command W w
:command Q q
