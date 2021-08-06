let g:python3_host_prog = $HOME .'/.venv/nvim/bin/python'
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

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' } " Sphinx integration

Plug 'google/vim-maktaba'             " Required by the other google plugins
Plug 'google/vim-glaive'              " Required by the other google plugins
Plug 'google/vim-searchindex'         " Display number of search matches & index of a current match
Plug 'google/vim-codefmt'             " utility for syntax-aware code formatting

Plug 'majutsushi/tagbar'              " Tags browser
Plug 'dyng/ctrlsf.vim'                " Code search tool
Plug 'vim-airline/vim-airline'        " Airline status line
Plug 'vim-airline/vim-airline-themes' " Base16 airline theme
Plug 'luochen1990/rainbow'            " Different colors for nested parentheses
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing whitespaces
Plug 'haya14busa/incsearch.vim'       " Highlight search results
Plug 'haya14busa/incsearch-fuzzy.vim' " Fuzzy incsearch
Plug 'osyo-manga/vim-over'            " Preview of searches/replaces
Plug 'scrooloose/nerdtree'            " File system explorer plugin
Plug 'Xuyuanp/nerdtree-git-plugin'    " Show files git status in NERDTree

Plug 'nvim-lua/popup.nvim'            " Dependency for telescope.nvim
Plug 'nvim-lua/plenary.nvim'          " Dependency for telescope.nvim
Plug 'nvim-telescope/telescope.nvim'  " Fuzzy finder

Plug 'tpope/vim-fugitive'             " Git plugin
Plug 'tomtom/tcomment_vim'            " Commenting in vim
Plug 'sickill/vim-pasta'              " Match indetation of pasted text
Plug 'roxma/vim-tmux-clipboard'       " Share clipboard with tmux
Plug 'tpope/vim-surround'             " Changes string surrounding characters
Plug 'tpope/vim-unimpaired'           " Various brackets mappings (like [e )
Plug 'dbakker/vim-projectroot'        " Detect the project root dir
Plug 'duff/vim-bufonly'               " Close all other buffers, used by 'bda' alias
Plug 'tmux-plugins/vim-tmux'          " Support for .tmux.conf in vim
Plug 'christoomey/vim-tmux-navigator' " Seamless navigation with tmux
Plug 'djoshea/vim-autoread'           " Automatically load buffers of file that chagned on the disk
Plug 'editorconfig/editorconfig-vim'  " Support editorconfig file for shared coding styles
Plug 'ludovicchabant/vim-gutentags'   " Automatic ctags
Plug 'chriskempson/base16-vim'        " Base16 theme support
Plug 'vim-scripts/zoomwintab.vim'     " Zoom into vim tab
Plug 'tpope/vim-sleuth'               " automatically adjust 'shiftwidth' and 'expandtab'

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

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>

nnoremap <c-f> :CtrlSF<Space>
nmap <leader>f <Plug>CtrlSFCwordPath
nnoremap <leader>cf :CtrlSFToggle<cr>

nmap <leader>tb :TagbarToggle<CR>

nnoremap <leader>z :ZoomWinTabToggle<cr>

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" fuzzy incsearch
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" deselect with esc
nnoremap <silent><esc> :noh<CR>

" edit/reload init.vim file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

nnoremap <leader>nt :NERDTreeFind<cr>

" Comment map
nmap <Leader>c gcc

" Fugitive
nmap <leader>ge :G edit<cr>
nmap <silent><leader>gr :G read<cr>
nmap <silent><leader>gb :G blame<cr>
nmap <leader>gs :G status<CR><C-w>20-

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

" Find files using Telescope
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <c-p> <cmd>Telescope git_files<cr>
nnoremap <c-b> <cmd>Telescope buffers<cr>
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
set textwidth=120
set colorcolumn=121

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

set noshowmode

set splitright
set splitbelow

set diffopt+=vertical

syntax on

" spell checking for .rst files
autocmd BufRead,BufNewFile *.rst set spell spelllang=en_us
set complete+=kspell

" ================ LUA config ================
" " -------------------- LSP ---------------------------------
:lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  require'completion'.on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "bashls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

EOF

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy', 'all']
" enable snippets completion
let g:completion_enable_snippet = 'UltiSnips'

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c


" -------------------- LSP ---------------------------------

" ================ Plugins Config ================

" === base16-vim ===
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" === ultisnips ===
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
" disable cache for snap universal tags
let g:tagbar_use_cache = 0

" === codefmt ===
Glaive codefmt yapf_executable=`$HOME .'/.venv/nvim/bin/yapf'`

" === vim-airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16'

" === rainbow ===
let g:rainbow_active = 1

" === vim-better-whitespaces ===
let g:strip_whitespace_confirm=0
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

" === ctrl-sf ===
let g:ctrlsf_mapping = {
    \ "next": "n",
    \ "prev": "N",
    \ }

let g:ctrlsf_extra_backend_args = {
    \ 'rg': '--no-ignore --hidden --follow --glob "!.git/*" --glob "!tags"'
    \ }

let g:ctrlsf_default_root = 'project+fw'

" === editorconfig ===
" editoconfig fugitive conflict
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" === gutentags ===
let g:gutentags_ctags_tagfile = ".tags"
" Ignore git temp files that casued error on exit
" https://github.com/ludovicchabant/vim-gutentags/issues/178
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
