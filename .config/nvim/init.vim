"    ______           __
"   / ____/  ____  __/ /___  _____
"  / __/ | |/_/ / / / / __ \/ ___/
" / /____>  </ /_/ / / /_/ (__  )
"/_____/_/|_|\__, /_/\____/____/
"           /____/

" Touche utilisée comme <leader>
let mapleader =" "

call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set nocompatible

" Titre de la fenêtre du terminal
set title

set relativenumber number
syntax on
filetype indent on

" Permet le scroll avec la souris et de passer automatiquement en mode VISUEL
set mouse=nicr
set mouse=a
set hidden
set clipboard+=unnamedplus
set incsearch
set nohlsearch
set smartcase
set noruler
set wildmode=longest,list,full
set splitbelow splitright
set noshowmode
set noerrorbells
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set scrolloff=8

" Thème de la barre
let g:lightline = {}
let g:lightline.colorscheme = 'hybrid'

" Remap splits navigation to just CTRL + hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Right> :vertical resize +3<CR>
noremap <silent> <C-Left> :vertical resize -3<CR>
noremap <silent> <C-Down> :resize +3<CR>
noremap <silent> <C-Up> :resize -3<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Raccourcis sauvegarde et quitter
map <C-s> :w<CR>
map <C-q> :q!<CR>

" Active Goyo pour permettre un lecture plus simple
map <leader>f :Goyo \| set linebreak<CR>
" Raccourcis pour compiler et ouvrir des fichiers
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Ouvrir le terminal dans vim
map <Leader>tt :vnew term://zsh<CR>

let g:gruvbox_transparent_bg = 1
colorscheme gruvbox
autocmd VimEnter * hi Normal ctermbg=none
" Template de page html vide
autocmd FileType html inoremap ;h <!DOCTYPE html><CR><html><CR><head><CR><link rel="stylesheet" href="style.css"><CR><meta charset="utf-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html><Esc>

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none
highlight Comment          cterm=italic
