" Inspired by https://github.com/odedlaz/dotfiles
let g:python_host_prog = $HOME .'/.virtualenvs/nvim2/bin/python'
let g:python3_host_prog = $HOME .'/.virtualenvs/nvim3/bin/python'
let g:mapleader = ","

setglobal encoding=utf-8
setglobal fileencoding=utf-8
scriptencoding utf-8


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

" Fast, Extensible, Async Completion Framework for Neovim
Plug 'roxma/nvim-completion-manager'

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Dark powered asynchronous unite all interfaces for Neovim/Vim8
Plug 'Shougo/denite.nvim'

" display tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
let g:tagbar_autofocus = 0
" auto open tagbar when opening a tagged file
" does the same as taglist.vim's TlistOpen.
autocmd VimEnter * nested :call tagbar#autoopen(1)

Plug 'craigemery/vim-autotag'

Plug 'google/vim-maktaba'

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


Plug 'dyng/ctrlsf.vim'
nnoremap <c-t> :CtrlSF<Space>
nnoremap <leader>ct :CtrlSFToggle<cr>

Plug 'troydm/zoomwintab.vim'
nnoremap <leader>z :ZoomWinTabToggle<cr>

Plug 'janko-m/vim-test'
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tv :TestVisit<CR>

" lint
Plug 'neomake/neomake'
augroup neomake_hooks
   au!
   autocmd BufWritePost * update | Neomake
augroup END

let g:neomake_open_list = 1
"let g:neomake_logfile = '/tmp/neomake.log'
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
         \ 'exe': $HOME .'/.virtualenvs/nvim3/bin/flake8',
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
nnoremap <silent><esc> :noh<CR>
nnoremap <esc>[ <esc>[

"live subsitution
set inccommand=split

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

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" --files: List files that would be searched but do not search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

Plug 'gcmt/wildfire.vim'
map <SPACE> <Plug>(wildfire-fuel)
vmap <C-SPACE> <Plug>(wildfire-water)

Plug 'zhou13/vim-easyescape'
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
cnoremap jk <ESC>
cnoremap kj <ESC>


Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'osyo-manga/vim-over'
Plug 'tomtom/tcomment_vim'
Plug 'fisadev/vim-isort'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-unimpaired'
Plug 'dbakker/vim-projectroot'

call plug#end()
"
" put the tags file in the git directory
let g:autotagTagsFile = projectroot#guess() .'/.git/tags'
"make sure fzf files run in the right directory
nnoremap <c-p> :execute ':Files ' projectroot#guess()<cr>


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

nnoremap <silent> ∆ :wincmd j<cr>
nnoremap <silent> ˚ :wincmd k<cr>
nnoremap <silent> ˙ :wincmd h<cr>
nnoremap <silent> ¬ :wincmd l<cr>

" do not automatically wrap on load
set nowrap

" do not automatically wrap text when typing
set formatoptions-=t

" add column indicator
set textwidth=80
set colorcolumn=+1

"Set the term title
set title
set titlestring=%F

"Show matching braces, etc.
set showmatch

"Show line number and position
set relativenumber
set number

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

"Default to 4 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" edit/reload init.vim file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

set hidden


colorscheme onedark
