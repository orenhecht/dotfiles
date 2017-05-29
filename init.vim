" Inspired by https://github.com/odedlaz/dotfiles

let g:mapleader = ","

setglobal encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8
"
"
" auto download plug-vim
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""
"""plugins"""
"""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug 'google/vim-maktaba'

" Easy configuration of maktaba plugins.
Plug 'google/vim-glaive'

" Display number of search matches & index of a current match
Plug 'google/vim-searchindex'

" utility for syntax-aware code formatting
Plug 'google/vim-codefmt'

augroup autoformat_settings
  au!
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer autopep8
augroup END

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

let g:LanguageClient_serverCommands = {
    \ 'python': ['pyls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

"auto complete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"set completeopt+=noselect
let g:deoplete#enable_at_startup = 1
"Plug 'zchee/deoplete-jedi'
" close preview window after select
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"
Plug 'Shougo/echodoc.vim'

" lint
Plug 'neomake/neomake'
augroup neomake_hooks
   au!
   autocmd BufWritePost * update | Neomake
augroup END

let g:neomake_open_list = 1
"let g:neomake_logfile = '/var/log/neovim/neomake.log'
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
         \ 'args': ['--format=default', '--ignore=E501'],
         \ 'errorformat':
         \ '%E%f:%l: could not compile,%-Z%p^,' .
         \ '%A%f:%l:%c: %t%n %m,' .
         \ '%A%f:%l: %t%n %m,' .
         \ '%-G%.%#',
         \ 'postprocess': function('neomake#makers#ft#python#Flake8EntryProcess')
         \ }


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

Plug 'joshdick/onedark.vim'
let g:airline_theme='onedark'

Plug 'ervandew/supertab'

Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

Plug 'ntpeters/vim-better-whitespace'
augroup better_whitespace
   au!
   let g:better_whitespace_filetypes_blacklist=['diff',
            \'gitcommit',
            \'unite',
            \'qf',
            \'help']
   autocmd BufEnter * EnableStripWhitespaceOnSave
 augroup END

Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

"live subsitution
set inccommand=split

Plug 'gcmt/wildfire.vim'
map <SPACE> <Plug>(wildfire-fuel)
vmap <C-SPACE> <Plug>(wildfire-water)

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <leader>nt :NERDTreeToggle<cr>

augroup nerdtree
   au!
   " open nerdtree when editing a directory
   autocmd StdinReadPre * let s:std_in=1
   autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

   "close vim if the only window left open is a NERDTree
   autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

"disable the builtin, bloated netrw plugin. We don’t need two filebrowsers.
let g:loaded_netrwPlugin=1
"let NERDTree respect the vim wildignore setting
"Rootignore converts .gitignore into wildignore
"thus making NERDTree respect gitignore!
let g:NERDTreeRespectWildIgnore=1

call plug#end()

" needs to go after plug#end
call glaive#Install()

"""""""""""""""
"""functions"""
"""""""""""""""

function! CreateDirectory (base, ...)
   for l:dir in a:000
      silent! execute '!mkdir ' a:base . '/' . l:dir . ' > /dev/null 2>&1'
   endfor
endfunction

"""""""""""""""""""
"""anything else"""
"""""""""""""""""""

"navigation mappings
noremap  <Up> :echo 'use k!'<cr>
noremap  <Down> :echo 'use j!'<cr>
noremap  <Left> :echo 'use h!'<cr>
noremap  <Right> :echo 'use l!'<cr>

nnoremap <C-Up> :wincmd +<cr>
nnoremap <C-Down> :wincmd -<cr>
nnoremap <C-Left> :wincmd <<cr>
nnoremap <C-Right> :wincmd ><cr>

nnoremap <C-j> :wincmd j<cr>
nnoremap <C-k> :wincmd k<cr>
nnoremap <C-h> :wincmd h<cr>
nnoremap <C-l> :wincmd l<cr>

" add column indicator
set textwidth=80
set colorcolumn=+1

"move line up or down
nmap ld :m +1<CR>
nmap lu :m -2<CR>

"Set the term title
set title
set titlestring=%F

"Show matching braces, etc.
set showmatch

"Show line number and position
set relativenumber

"Highlight current line
set cursorline

"create all needed directories
call CreateDirectory('~/.vim', 'undo', 'backups', 'swaps')

"maintain undo history between sessions
set undofile
set undodir=~/.vim/undo
set noswapfile

"centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists('&undodir')
   set undodir=~/.vim/undo
endif
"
"Don’t create backups when editing files in certain directories
set backupskip=/tmp/*

"Default to soft tab
set expandtab
set smartindent

"Default to 3 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set hidden

" Change numbering in insert mode
augroup set_linenumbers_on_enter_and_leave
   au!
   autocmd FocusLost * :set number
   autocmd InsertEnter * :set number

   autocmd FocusGained * :set relativenumber
   autocmd InsertLeave * :set relativenumber
augroup END

colorscheme onedark
