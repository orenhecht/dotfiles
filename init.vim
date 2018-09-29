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


" ================ Plugins ================

call plug#begin('~/.config/nvim/plugged')

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-ultisnips'

Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
Plug 'google/vim-searchindex' " Display number of search matches & index of a current match
Plug 'google/vim-codefmt' " utility for syntax-aware code formatting

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'majutsushi/tagbar'
Plug 'craigemery/vim-autotag'
Plug 'dyng/ctrlsf.vim'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'ntpeters/vim-better-whitespace'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'osyo-manga/vim-over'
Plug 'tomtom/tcomment_vim'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'dbakker/vim-projectroot'
Plug 'duff/vim-bufonly'
Plug 'tmux-plugins/vim-tmux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tudorprodan/pyfinder.vim'
Plug 'djoshea/vim-autoread'
Plug 'davidhalter/jedi-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'tweekmonster/impsort.vim'

Plug 'joshdick/onedark.vim'

call plug#end()
call glaive#Install()


" ================ Functions ================

function! CreateDirectory (base, ...)
   for l:dir in a:000
      silent! execute '!mkdir ' a:base . '/' . l:dir . ' > /dev/null 2>&1'
   endfor
endfunction


" ================ Abbreviations ====================

cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev bda BufOnly


" ================ Mappings ================

nnoremap <C-Up> :wincmd +<cr>
nnoremap <C-Down> :wincmd -<cr>
nnoremap <C-Left> :wincmd <<cr>
nnoremap <C-Right> :wincmd ><cr>

nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

nnoremap <c-f> :CtrlSF<Space>
nmap <leader>f <Plug>CtrlSFCwordPath
nnoremap <leader>cf :CtrlSFToggle<cr>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nmap <leader>tb :TagbarToggle<CR>

nnoremap <leader>z :ZoomWinTabToggle<cr>

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nnoremap <silent><leader><SPACE> :noh<CR>
nnoremap <silent><esc> :noh<CR>
nnoremap <esc>[ <esc>[

" edit/reload init.vim file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

nnoremap <leader>nt :NERDTreeFind<cr>

map <SPACE> <Plug>(wildfire-fuel)
vmap <C-SPACE> <Plug>(wildfire-water)

cnoremap jk <ESC>
cnoremap kj <ESC>

" make sure fzf files run in the right directory
nnoremap <c-p> :execute ':Files ' projectroot#guess()<cr>
nnoremap <c-b> :execute ':Buffers'<cr>

" Comment map
nmap <Leader>c gcc

nnoremap <leader>rr :FormatCode<CR>
nnoremap <leader>l :lopen<CR>

" Fugitive
nmap <leader>ge :Gedit<cr>
nmap <silent><leader>gr :Gread<cr>
nmap <silent><leader>gb :Gblame<cr>

" Textmate style indentation
vmap <leader>[ <gv
vmap <leader>] >gv
nmap <leader>[ <<
nmap <leader>] >>

" Close buffer but not split
nmap <leader>cb :b#<bar>bd#<CR>

nnoremap <C-e> 10<C-e>
nnoremap <C-y> 10<C-y>


vnoremap <leader>fl :FormatLines<CR>

nnoremap <leader>is :<c-u>ImpSort!<cr>

" ================ Other Settings ================

" do not automatically wrap on load
set nowrap

set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" " code folding settings
set foldmethod=indent       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
set foldlevel=1

" do not automatically wrap text when typing
set formatoptions-=t

" add column indicator
set textwidth=100
set colorcolumn=101

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
set cindent

"Default to 4 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set hidden

set inccommand=split

" Reload buffer it was edited outside of vim
augroup set_update
   au!
   set autoread
   au CursorHold * checktime
augroup END

set noshowmode

set splitright
set splitbelow

set diffopt+=vertical

set clipboard+=unnamedplus

syntax on
colorscheme onedark

" ================ Plugins Config ================

" === ncm2 ===
" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Update the popup menu faster
let ncm2#popup_delay = 5
" should make it faster
let ncm2#complete_length = [[1, 1]]
" Use new fuzzy based matches
let g:ncm2#matcher = 'substrfuzzy'

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" === ultisnips ===
set runtimepath+=~/.config/nvim
let g:UltiSnipsSnippetsDir = "~/.config/nvim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/plugged/vim-snippets/UltiSnips', 'UltiSnips']
"
" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger         = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger      = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger     = "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" === tagbar ===
" display tags in a window, ordered by scope
let g:tagbar_autofocus = 0
" auto open tagbar when opening a tagged file
" does the same as taglist.vim's TlistOpen.
autocmd VimEnter * nested :call tagbar#autoopen(1)

Glaive codefmt yapf_executable=`$HOME .'/.virtualenvs/cheetah/bin/yapf'`

" === ale ===
let g:ale_python_pylint_executable = '/home/dn/.virtualenvs/cheetah/bin/pylint'
let g:ale_python_pylint_options = '--rcfile ' . '/home/dn/.pylintrc'
let g:ale_linters = {
\   'python': ['pylint'],
\}
let g:ale_open_list = 0
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" === vim-airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'

" === rainbow ===
let g:rainbow_active = 1

" === vim-better-whitespaces ===
let g:better_whitespace_filetypes_blacklist=['diff',
         \'gitcommit',
         \'unite',
         \'qf',
         \'help']
autocmd BufEnter * EnableStripWhitespaceOnSave

" === NERDTree ===
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

" === fzf ===
" --files: List files that would be searched but do not search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
 let $FZF_DEFAULT_COMMAND = 'ag --ignore .git --hidden -g ""'

" === vim-easyescape
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100

" === autotag ===
" put the tags file in the git directory
let g:autotagTagsFile = projectroot#guess() .'/.git/tags'


let g:ctrlsf_mapping = {
	\ "next": "n",
	\ "prev": "N",
	\ }

let g:ctrlsf_extra_backend_args = {
    \ 'ag': '--ignore .git --hidden'
    \ }

let g:ctrlsf_default_root = 'project+fw'

" editoconfig fugitive conflict
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
