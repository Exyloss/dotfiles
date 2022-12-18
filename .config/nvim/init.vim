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
Plug 'cocopon/lightline-hybrid.vim'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'sheerun/vim-polyglot'
Plug 'pineapplegiant/spaceduck'
Plug 'chrisbra/csv.vim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'gregsexton/MatchTag'
" Plug 'dense-analysis/ale'
call plug#end()

set nocompatible

set autoindent

" Titre de la fenêtre du terminal
set title

set relativenumber number
syntax enable
filetype plugin on

" Permet le scroll avec la souris et de passer automatiquement en mode VISUEL
set mouse=nicr
set mouse=a
set hidden
set clipboard+=unnamedplus
set incsearch
set nohlsearch
set ignorecase
set smartcase
set noruler
set wildmode=longest,list,full
set splitbelow splitright
set noshowmode
set noerrorbells
set noswapfile
set nobackup
set shiftwidth=4 tabstop=4 softtabstop=4 expandtab
set scrolloff=8
set termguicolors
set signcolumn=yes
set path+=**

" Thème de la barre
let g:lightline = {}
let g:lightline.colorscheme = 'spaceduck'

" fzf config
let g:fzf_preview_window = []

" ale config
let g:ale_fixers = {
 \ 'html': ['prettier'],
 \ 'css': ['stylelint'],
 \}
let g:ale_linters = {
 \ 'html': ['htmlhint'],
 \ 'css': ['stylelint'],
 \}
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1

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
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <leader>f :Files <CR>

" Raccourcis sauvegarde et quitter
map <C-s> :w<CR>
map <C-q> :q!<CR>

" Active Goyo pour permettre un lecture plus simple
" Raccourcis pour compiler et ouvrir des fichiers
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Ouvrir le terminal dans vim
map <Leader>tt :vnew term://zsh<CR>

let g:gruvbox_transparent_bg = 1

" Raccourcis emmet
let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','

" Tagalong config
let g:tagalong_filetypes = ['html']
let g:tagalong_verbose = 1

" Spaceduck
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme spaceduck3

autocmd VimEnter * hi Normal ctermbg=none
" autocmd VimEnter *.sh,*.py normal gg=G''
" Template de page html vide
autocmd FileType html inoremap ;h <!DOCTYPE html><CR><html><CR><head><CR><meta name="viewport" content="width=device-width, initial-scale=1"><CR><link rel="stylesheet" href="style.css"><CR><meta charset="utf-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html><Esc>

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Retire les espaces inutiles en fin de ligne lors de la sauvegarde du fichier
fun! <SID>StripTrailingWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

if exists("did_load_csvfiletype")
  finish
endif
let did_load_csvfiletype=1

augroup filetypedetect
  au! BufRead,BufNewFile *.csv,*.dat	setfiletype csv
augroup END

autocmd FileType c,cpp,java,php,ruby,python,rust,go autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Lance un script qui efface les fichiers builds des .tex quand je ferme un fichier .tex.
autocmd VimLeave *.tex !texclear %
" Commentaires en italique
highlight Comment cterm=italic
" Forcer le fond du terminal transparent
hi Normal ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
