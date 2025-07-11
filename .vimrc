scriptencoding utf-8
set encoding=utf-8

highlight ColorColumn ctermbg=gray
set colorcolumn=80

call plug#begin('~/.vim/plugged')

Plug 'jxnblk/vim-mdx-js'
Plug 'folke/which-key.nvim'

Plug 'chrisbra/Colorizer'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'

Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'github/copilot.vim'

" Trouble
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'

" Theme
Plug 'morhetz/gruvbox'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'nvim-lua/plenary.nvim'

Plug 'vim-test/vim-test'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-projectionist'

" Syntax
Plug 'Lokaltog/vim-easymotion'
Plug 'bouk/vim-markdown'
Plug 'burner/vim-svelte'
Plug 'chase/vim-ansible-yaml'

" Elixir
Plug 'elixir-editors/vim-elixir' " Syntax, indentation, vim-dadbod support
" Plug 'mhanberg/elixir.nvim' " Elixir LS, :Mix, vim-projectionist support
" Plug 'mfussenegger/nvim-dap' " debugger
Plug 'c-brenn/fuzzy-projectionist.vim'
Plug 'andyl/vim-projectionist-elixir' " To get :A working

" Kotlin
Plug 'udalov/kotlin-vim'

Plug 'avdgaag/vim-phoenix'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'tomlion/vim-solidity'
Plug 'toyamarinyon/vim-swift'
Plug 'vim-ruby/vim-ruby'

call plug#end()

" Copilot setup
imap <silent><script><expr> <C-h> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
let g:copilot_assume_mapped = v:true
let g:copilot_tab_fallback = ""

" An attempt to fix vim-rails slowness. Pr
" https://github.com/tpope/vim-rails/issues/401#issuecomment-423247894
set regexpengine=1

" https://stackoverflow.com/questions/2169645/vims-autocomplete-is-excruciatingly-slow
" An attempt to make completion faster
" set complete-=i

" Enable syntax hightlighting
syntax enable
filetype plugin indent on
set breakindent

if 1
  let g:ack_default_options = " -H --nocolor --nogroup --column --type-add css=.sass,.scss --ignore-dir=node_modules --ignore-dir=deps --ignore-dir=_build --ignore-dir=ios --ignore-dir=expo/android --ignore-dir=tmp --ignore-dir=doc --ignore-dir=docs --ignore-dir=vendor --ignore-dir=app/assets/builds --ignore-dir=log --ignore-dir=coverage --ignore-dir=.yarn --ignore-dir=.next --ignore-dir=Oase.app"
  if executable('ag')
    let g:ackprg = 'ag --vimgrep --ignore-dir=node_modules --ignore-dir=_build --ignore-dir=deps --ignore-dir=.next --ignore-dir=Oase.app --ignore-dir=.yarn --ignore-dir=ios --ignore-dir=expo/android --ignore-dir=tmp --ignore-dir=doc --ignore-dir=docs --ignore-dir=vendor --ignore-dir=log --ignore-dir=coverage --ignore-dir=app/assets/builds --ignore=webpack-stats.json'
  endif

  let g:ctrlp_custom_ignore = '\v[\/](\.git|\.hg|\.svn|node_modules|_build|deps|ios|expo\/android|svg|doc|docs|builds|\.elixir_ls|\.yarn|\.next)$'
  let g:ctrlp_show_hidden = 1
  let g:ctrlp_max_files=0
endif

" To avoid vim hanging when open parens
" Taken from https://vi.stackexchange.com/questions/5128/matchpairs-makes-vim-slow
let g:matchparen_timeout = 10
let g:matchparen_insert_timeout = 10

ab descrive describe
ab bb byebug
ab scsv describe "exporting CSV" do<CR>subject { handler.to_csv(user_id: user_id) }<CR>it { is_expected.to include "foo" }<CR>end<esc>2k

let g:rails_path_additions=['domain_model', 'app/domain', 'spec/cassettes', 'spec/domain', 'spec/domain_model', 'lib/domain', 'vouchers/lib', 'billing/lib', 'global/lib']

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

" Gist stuff
let g:gist_post_private = 1
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

autocmd FileType tex let b:dispatch = 'pdflatex %'

set backupcopy=auto

set softtabstop=2 shiftwidth=2 expandtab
set tabstop=2
set scrolloff=10

" Search stuff
set ignorecase
set smartcase
set incsearch
set hlsearch " highlight results
nmap <leader><cr> :nohl<cr>
nmap <leader>n nzz

" Create all directories needed for file to be saved
nnoremap <Leader>mkdir :call mkdir(expand("%:p:h"), "p")<CR>

set pastetoggle=<F2>
set number " line numbers

" Show invisible chars
set listchars=nbsp:¬,tab:»·,trail:· " invisible chars
set list

" Allow backspace to delete everything
set backspace=indent,eol,start

set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
if exists("+undofile")
  set undofile
  set undodir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
endif

" auto indent
set ai

" Folding
set foldmethod=manual
set foldlevelstart=99
map <leader>1 :set foldmethod=syntax foldlevel=1 foldmethod=manual<CR>
map <leader>2 :set foldmethod=syntax foldlevel=2 foldmethod=manual<CR>
map <leader>3 :set foldmethod=syntax foldlevel=3 foldmethod=manual<CR>
map <leader>4 :set foldmethod=syntax foldlevel=4 foldmethod=manual<CR>
map <leader>5 :set foldmethod=syntax foldlevel=5 foldmethod=manual<CR>
map <leader>6 :set foldmethod=syntax foldlevel=6 foldmethod=manual<CR>
map <leader>7 :set foldmethod=syntax foldlevel=7 foldmethod=manual<CR>
map <leader>8 :set foldmethod=syntax foldlevel=8 foldmethod=manual<CR>
map <leader>9 :set foldmethod=syntax foldlevel=9 foldmethod=manual<CR>
map <leader>0 :set foldmethod=syntax foldlevel=99 foldmethod=manual<CR>
nmap <space> :set foldmethod=syntax<CR>za<CR>:set foldmethod=manual<CR>k
nmap <leader><space> :set foldmethod=manual foldlevel=99<CR>

nmap 1 :!

" Pane navigation
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

" Move up/down wrapped lines
nmap j gj
nmap k gk

" To make Vim break lines nicely
set linebreak

" Unimpaired new bindings
nmap ( [
nmap ) ]
omap ( [
omap ) ]
xmap ( [
xmap ) ]

" Open previous file
nmap <leader>p <c-^>

nmap <C-f> :Ack! 

" Go to cassette
nmap gc :e spec/cassettes/<cfile>.yml<CR>
nmap gdc :! rm spec/cassettes/<cfile>.yml<CR>

" Pane splitting
nnoremap <Leader>h :sp<CR>
nnoremap <Leader>s :vsp<CR>
nnoremap <Leader>v :vsp<CR>

nnoremap <Leader>r :CtrlPMRU<cr>

set path+=$PWD/src
set path+=$PWD/app
set path+=$PWD/src/redux
set path+=$PWD/state
set path+=$PWD/spec/cassettes

set suffixesadd+=.yml

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

nmap 8q (q
nmap 9q )q
nmap 8f (f
nmap 9f )f

function! InEventHandler()
return match(expand("%"), "_handler") != -1 && match(expand("%"), "gdpr/event_handlers") != -1
endfunction
function! InEvent()
return match(expand("%"), "events") != -1
endfunction
function! InReadModel()
return match(expand("%"), "app/models") != -1
endfunction
function! InReadModelHandler()
return match(expand("%"), "_handler") != -1 && match(expand("%"), "gdpr/read_model_handlers") != -1
endfunction
function! GoToEventHandler()
let context=reverse(split(expand("%"), "/"))[2]
let filename=reverse(split(expand("%"), "/"))[0]
let filename=substitute(filename, '_spec', '', '')
let fileWithoutExtention=split(filename, '\.')[0]
let filepath=join(['app/domain/zetland/gdpr/event_handlers', context, join([join([fileWithoutExtention, 'handler'], '_'), 'rb'], '.')], '/')
let command=join([':e', filepath], ' ')
if filereadable(filepath)
  execute command
else
  execute join(['!bin/rails', 'generate', 'domain_event', join([context, fileWithoutExtention], '/'), '-s'], ' ')
  execute command
endif
endfunction
function! GoToEvent()
let context=reverse(split(expand("%"), "/"))[1]
let filename = reverse(split(expand("%"), "/"))[0]
let file=substitute(filename, '_handler', '', '')
let file=substitute(file, '_spec', '', '')
let command=join([':e app/domain/zetland', context, 'events', file], '/')
execute command
endfunction
function! GoToReadModelHandler()
let context=reverse(split(expand("%"), "/"))[1]
let filename=reverse(split(expand("%"), "/"))[0]
let filename=substitute(filename, '_spec', '', '')
let fileWithoutExtention=split(filename, '\.')[0]
let filepath=join(['app/domain/zetland/gdpr/read_model_handlers', context, join([join([fileWithoutExtention, 'handler'], '_'), 'rb'], '.')], '/')
let command=join([':e', filepath], ' ')
if filereadable(filepath)
  execute command
else
  execute join(['!bin/rails', 'generate', 'read_model_handler', join([context, fileWithoutExtention], '/'), '-s'], ' ')
  execute command
endif
endfunction
function! GoToReadModel()
let context=reverse(split(expand("%"), "/"))[1]
let filename = reverse(split(expand("%"), "/"))[0]
let file=substitute(filename, '_handler', '', '')
let file=substitute(file, '_spec', '', '')
let command=join([':e app/models/', context, file], '/')
let command=substitute(command, 'models//models', 'models', '')
execute command
endfunction
function! ToggleHandler()
if InEventHandler()
  call GoToEvent()
elseif InEvent()
  call GoToEventHandler()
elseif InReadModel()
  call GoToReadModelHandler()
elseif InReadModelHandler()
  call GoToReadModel()
endif
endfunction

map gh :call ToggleHandler()<CR>

" vim-rspec
" map <Leader>T :call RunCurrentSpecFile()<CR>
" map <Leader>t :call RunNearestSpec()<CR>
" map <Leader>l :call RunLastSpec()<CR>
" map <Leader>A :call RunAllSpecs()<CR>
" let g:rspec_command = "Dispatch bin/rspec {spec}"

" vim-test
map <Leader>T :TestFile<CR>
map <Leader>t :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>A :TestSuite<CR>
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

map <Leader>see :let $LET_ME_SEE=1<CR>
map <Leader>hide :let $LET_ME_SEE=''<CR>

" vim-dispatch
map <Leader>d :Dispatch<CR>
map <Leader>D :Dispatch!<CR>
map <Leader>f :Focus bin/test %
map <Leader><Leader>T :Focus bin/rails test<CR>

" build mmd
map <Leader>m :Dispatch %:h/../bin/build %<CR>

" Use ctrl + s to save
noremap <C-S> :wa<CR>
vnoremap <C-S> <C-C>:wa<CR><Esc>
inoremap <C-S> <C-O>:wa<CR><Esc>

" Use ctrl + q to close
noremap <silent> <C-Q> :q<CR>
noremap <silent> <C-A> :qa<CR>

" JSX
let g:jsx_ext_required = 0 " Do not require .jsx

set background=dark
colorscheme gruvbox

" Android shake, to reload js
map <Leader><Leader>a :Dispatch! adb shell input keyevent 82<CR>
map <Leader><Leader>o :Dispatch! npx uri-scheme open "https://oase.app/oase/test" --ios<CR>
map <Leader><Leader>h :Dispatch! npx uri-scheme open "https://oase.app/" --ios<CR>

" use ,cc to copy the current visual selection that was yanked
nnoremap <leader>co :call system('pbcopy', @0)<CR>
vnoremap <leader>co y:call system('pbcopy', @0)<CR>

let $BASH_ENV="~/dotfiles/.bash_aliases"

function! SaveSess()
  :call system('mkdir ' . getcwd() . '/.vim')
  execute 'mksession! ' . getcwd() . '/.vim/.session'
endfunction

function! RestoreSess()
  if filereadable(getcwd() . '/.vim/.session')
    execute 'so ' . getcwd() . '/.vim/.session'
    if bufexists(1)
      for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
          exec 'sbuffer ' . l
        endif
      endfor
    endif
  endif
endfunction

map <Leader><Leader>s :call SaveSess()<CR>
map <Leader><Leader>l :call RestoreSess()<CR>

set sessionoptions-=options  " Don't save options

" reload safari
function! ReloadBrowser()
  wa
  Dispatch! osascript ~/dotfiles/bin/reload_safari.applescript
endfunction
nnoremap <leader><leader>rb :call ReloadBrowser()<CR>

" reload Sizzy
function! ReloadSizzy()
  wa
  Dispatch! osascript ~/dotfiles/bin/reload_sizzy.applescript
endfunction
nnoremap <leader><leader>rs :call ReloadSizzy()<CR>

" reload react native
function! ReloadReactNative()
  wa
  Dispatch! curl http://localhost:8081/reload
endfunction
nnoremap <leader><leader>rn :call ReloadReactNative()<CR>


" Make RagTag work in markdown
autocmd FileType markdown call RagtagInit()
let g:ragtag_global_maps = 1

" Remove red underscore in Markdown
au BufReadPost,BufNewFile *.md syn match markdownError "\w\@<=\w\@="

" start spell in Markdown
autocmd BufRead,BufNewFile *.markdown setlocal spell

"
nmap zk :e **/*<c-r>=expand("<cword>")<cr>

" include coc vimrv
" source ~/dotfiles/.vimrc-coc

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
    let @/ = ''
    if exists('#auto_highlight')
        au! auto_highlight
        augroup! auto_highlight
        setl updatetime=4000
        echo 'Highlight current word: off'
        return 0
    else
        augroup auto_highlight
            au!
            au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
        augroup end
        setl updatetime=100
        echo 'Highlight current word: ON'
        return 1
    endif
endfunction

set completeopt=menu,menuone,noselect

source ~/dotfiles/.vimrc-cmp
source ~/dotfiles/.vimrc-mason
source ~/dotfiles/.vimrc-lsp
source ~/dotfiles/.vimrc-trouble
" source ~/dotfiles/.vimrc-mhanberg-elixir
source ~/dotfiles/.vimrc-elixir-ls
" source ~/dotfiles/.vimrc-dap
