"turn on line nubmers
set number
"==========================================================
" ??
set tags=./tags;$HOME,tags;$HOME
"==========================================================

" Always wrap long lines:
set wrap
set tabstop=2       " The width of a TAB is set to 2.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 2.

set shiftwidth=2    " Indents will have a width of 2

set softtabstop=2   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces
set smarttab	    " Keep ident in new line
"=========================================================
" set xml syntax for *.launch files
autocmd BufNewFile,BufRead *.launch   set syntax=xml
" set markdown syntax for *.md files
au BufRead,BufNewFile *.md set filetype=markdown

"change <leader> mapping
let mapleader = "\<Space>"
"turn on/of search highlighting
nnoremap <F3> :set hlsearch!<CR>

"=========================================================
" NERDTree configuration
" open NERDTree when starting vim without any files specified
" eg.: $vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim, when NERDTree is the only open window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"=========================================================
filetype plugin indent on

" toggle between paste/nopaste mode (with autoident off/on)
set pastetoggle=<F10>

" pathogen.vim plugin manager
execute pathogen#infect() 
"=========================================================
" colorscheme
syntax on
" let g:solarized_termcolors=256
set t_Co=256
" set background=light
" colorscheme solarized

" OceanicNext color scheme configuration
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
