" Setting `nocompatible` mode by default
set nocompatible

" Turn syntax highlighting on
syntax on

" Show line numbers
set number

" Show relative line number
set relativenumber

" Show the status line always at bootom, even if only 1 window open
set laststatus=2

" Intuitive backspace
set backspace=indent,eol,start

" Tweak for search, ignore case by default unless has capital in term
set ignorecase
set smartcase

" Turn off ex mode from Normal mode
nmap Q <Nop>

" Disable bell
set noerrorbells visualbell t_vb=

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
