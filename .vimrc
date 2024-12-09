set nocompatible
set backspace=indent,eol,start
set smartindent
set autoindent

" Line numbers
set number
set relativenumber

" TAB settings
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Easier split nav normal mode
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Easier split nav terminal mode
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" Natural split openeing
set splitbelow
set splitright

" clang-format binds to ctrl-i 
if has('python')
 map <C-I> :pyf ~/.vim-custom/clang-format.py<cr>
 imap <C-I> <c-o>:pyf ~/.vim-custom/clang-format.py<cr>
elseif has('python3')
 map <C-I> :py3f ~/.vim-custom/clang-format.py<cr>
 imap <C-I> <c-o>:py3f ~/.vim-custom/clang-format.py<cr>
endif
