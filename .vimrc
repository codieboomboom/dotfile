"Plugins stuffs"
call plug#begin('~/.config/vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'ayu-theme/ayu-vim' " Add ayu theme colorscheme
call plug#end()
filetype plugin indent on "For vim-commentary plugin"

" Generic, important should have
set nocompatible
syntax on                   "syntax highlighting
set number                  " Show line numbers
set relativenumber          " Show relative line number
set laststatus=2            " Show status line at bottom always

" Intuitive backspace
set backspace=indent,eol,start

" Turn off ex mode from Normal mode
nmap Q <Nop>

" Disable bell
set noerrorbells visualbell t_vb=

" ######## Encoding ########
" UTF-8 everywhere avoids random character rendering issues
set encoding=utf-8
set fileencoding=utf-8

" ######## Indentation ########
" VSCode auto-indents and uses spaces by default; mirror that.
set expandtab         " tabs are expanded to spaces
set tabstop=4         " a tab renders as 4 spaces
set shiftwidth=4      " >> and << shift by 4
set softtabstop=4     " backspace over 4 spaces as if it were a tab
set autoindent        " copy indent from previous line on <CR>
set smartindent       " add indent after { and similar tokens

" ######## Search ########
" VSCode highlights matches live; these two enable the same behavior.
set hlsearch          " highlight all matches
set incsearch         " jump to match as you type
set ignorecase        " ignore case by default
set smartcase

" ######## Buffer / file handling ########
" `hidden` lets you switch buffers without saving — essential once you work
" with multiple files. Without it, vim nags you on every :bnext.
set hidden
" Reload files that changed on disk (e.g. from git checkout), like VSCode does.
set autoread
" Skip swap/backup clutter
set noswapfile
set nobackup
set nowritebackup

" Share the system clipboard so yank/paste works with other apps.
" Requires compiled with +clipboard (check `vim --version | grep clipboard`).
set clipboard=unnamed

" ######## Visual feedback ########
set cursorline        " highlight the line the cursor is on
set showmatch         " briefly flash matching bracket when you type one
set scrolloff=8       " keep 8 lines of context above/below cursor
set sidescrolloff=8   " same, but horizontally
set signcolumn=yes    " always render sign column so text doesn't jump
set colorcolumn=80   " soft visual ruler for line length
set nowrap            " don't wrap long lines (toggle with `:set wrap`)
set wildmenu          " menu-style tab completion on : commands
set wildmode=longest:full,full

" ######## Color Scheme #########
set termguicolors     " enable true colors support
let ayucolor="dark"   " matching dark|mirage|light to the version of theme
colorscheme ayu

" ######## Key Rebind Here ##########
" Prevent bad habit in vim in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Remap leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "

" ######## Quality-of-life remaps ########
" Clear search highlight quickly (hlsearch is great until it isn't)
nnoremap <leader><space> :nohlsearch<CR>
" Keep cursor centered when jumping through search results
nnoremap n nzzzv
nnoremap N Nzzzv
" Keep cursor centered when moving up/down by half page
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz 
" ######## Buffer / file handling ########
" `hidden` lets you switch buffers without saving — essential once you work
" with multiple files. Without it, vim nags you on every :bnext.
set hidden
" Reload files that changed on disk (e.g. from git checkout), like VSCode does.
set autoread
" Skip swap/backup clutter
set noswapfile
set nobackup
set nowritebackup

" Share the system clipboard so yank/paste works with other apps.
" Requires vim compiled with +clipboard (check `vim --version | grep clipboard`).
set clipboard=unnamed

" ######## Visual feedback ########
set cursorline        " highlight the line the cursor is on
set showmatch         " briefly flash matching bracket when you type one
set scrolloff=8       " keep 8 lines of context above/below cursor
set sidescrolloff=8   " same, but horizontally
set signcolumn=yes    " always render sign column so text doesn't jump
set colorcolumn=80   " soft visual ruler for line length
set nowrap            " don't wrap long lines (toggle with `:set wrap`)
set wildmenu          " menu-style tab completion on : commands
set wildmode=longest:full,full

" ######## Key Rebind Here ##########
" Prevent bad habit in vim in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Remap leader key to space
nnoremap <SPACE> <Nop>
let mapleader=" "
