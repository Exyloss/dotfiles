" Touche utilisée comme <leader>
let mapleader =" "

call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
call plug#end()

set nocompatible

" Titre de la fenêtre du terminal
set title

set relativenumber number
syntax on
filetype plugin on

" Permet le scroll avec la souris et de passer automatiquement en mode VISUEL
set mouse=nicr
set mouse=a

set clipboard+=unnamedplus
set nohlsearch
set noruler
set wildmode=longest,list,full
set splitbelow splitright
set noshowmode

" Thème de la barre
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }
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
" Template de page html vide
autocmd FileType html inoremap ;h <!DOCTYPE html><CR><html><CR><head><CR><link rel="stylesheet" href="style.css"><CR><meta charset="utf-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html><Esc>

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o



highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none
highlight Comment          cterm=italic
autocmd VimEnter * hi Normal ctermbg=none
