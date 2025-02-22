" vim package defaults loading
" if !has('nvim')
"     " Load vim defaults
"     unlet! skip_defaults_vim
"     source $VIMRUNTIME/defaults.vim
" endif "not nvim

" vim specific colors
if !has('nvim')
    set termguicolors
    colorscheme catppuccin_mocha
endif


" Disable vi compatibility
set nocompatible

" Filetype detection and highlighting
filetype on
filetype plugin on
filetype indent on
syntax on

" Line numbers
set number
set relativenumber

" Hightlight cursor line
set cursorline
" set cursorcolumn

" Limit cursor scroll lines
set scrolloff=10

" Convenience settings
set nowrap " no line wrapping
set showcmd " show last command typed
set showmode " show the vim modal you are in
set showmatch " show matching words during search
set hlsearch " use highlighting when searching
set history=1000 " number of commands to saave in history (default = 20)

" vim cmd settings
set wildmenu " autocompletion menu after pressing TAB
set wildmode=list:longest " similar to bash completion
set wildignore=*.decx,*.jpg,*.png,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " ignore non-plain-text files

" Search settings
set incsearch " incremental highlighting while searching
set ignorecase " ignore casing for lower letter searches
set smartcase " override ignore case if search has captical letters

set backspace=indent,eol,start
set smartindent
set autoindent

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

" Make background transparent
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

