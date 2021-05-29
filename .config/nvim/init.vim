let mapleader =" "

call plug#begin('~/.vim/plugged')
Plug 'junegunn/goyo.vim'
call plug#end()

hi StatusLine ctermbg=black ctermfg=cyan
set nocompatible
set number
syntax on
filetype plugin on
set wildmode=longest,list,full
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-s> :w<CR>
map <C-q> :q!<CR>
map <C-b> aß 
map <leader>f :Goyo \| set linebreak<CR>
map <leader>s :!clear && spellcheck %<CR>
map <leader>p :!clear && python %<CR>
map <leader>m :!clear && pandoc % -o %.pdf <CR><CR>
map <leader>g :!clear && groff -Kutf8 -ms % -T pdf > %.pdf && zathura %.pdf <CR><CR>

autocmd FileType html inoremap ;h <!DOCTYPE html><CR><html><CR><head><CR><style type="text/css" src=""></style><CR><meta charset="utf-8"><CR><title></title><CR></head><CR><body><CR><CR></body><CR></html><Esc>

nnoremap <F5> :GundoToggle<CR>

" Formats the statusline
set statusline=[%f]     " file name
set statusline+=[%{strlen(&fenc)?&fenc:'none'}] "file encoding
set statusline+=%y      "filetype
set statusline+=%h      "help file flag
set statusline+=[%{getbufvar(bufnr('%'),'&mod')?'modified':'saved'}] "modified flag
set statusline+=%r      "read only flag

set statusline+=\ %=                     " align left
set statusline+=Ligne:%l/%L	         " line X of Y [percent of file]
set statusline+=\ Colonne:%c             " current column
set statusline+=\ ASCII:%b               " ASCII and byte code under cursor
