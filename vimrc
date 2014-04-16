execute pathogen#infect()
syntax on
filetype plugin indent on

set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set scrolloff=3
set ignorecase
set smartcase
set incsearch
set pastetoggle=<F2>
set number

noremap <c-t> <Esc>:FufFile **/<CR>

nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

nnoremap ,r :w<CR>:Dispatch spring test %<CR>
nnoremap ,t :NERDTreeFind<CR>
nnoremap ,v :vsp<CR>
nnoremap ,s :vsp<CR>
nnoremap ,h :sp<CR>
