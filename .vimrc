" Victor's vimrc

" GENERAL ---------------------------------------------------------------- {{{

" copy neovim settings to vim
if !has('nvim')
    " Disable vi compatibility
    set nocompatible
    
    " If file is changed outside of vim, read it again
    set autoread
 
    " no bell from vim
    set belloff=all 
    "
    " ttimeout settings to reduce lag when starting with <ESC>
    set ttimeout        " enable separate terminal key timeout
    set ttimeoutlen=50  " set it to 50ms for fast <C-[> etc.

    set showcmd " show last command typed
    
    set autoindent " copy indent from current line when starting a new line
    set smarttab " helps with tabwidth alignment
endif

" Make background transparent
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

" Filetype detection
filetype on
filetype plugin on
filetype indent on
syntax on

" Line numbers
set number
set relativenumber

" Highlight cursor line
set cursorline
" set cursorcolumn

" Limit cursor scroll lines
set scrolloff=10

" Convenience settings
set nowrap " no line wrapping
set showmode " show the vim modal you are in
set showmatch " show matching words during search
set hlsearch " use highlighting when searching
set history=1000 " number of commands to save in history (default = 20)

" vim cmd autocomplete
set path+=** " Search down into subfolders. Provides tab-completion for all file-related tasks
set wildmenu " autocompletion menu after pressing TAB
set wildmode=list:longest " similar to bash completion
set wildignore=*.decx,*.jpg,*.png,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " ignore non-plain-text files

" Search settings
set incsearch " incremental highlighting while searching
set ignorecase " ignore casing for lower letter searches
set smartcase " override ignore case if search has captical letters
set backspace=indent,eol,start " allow for using backspace over autoindent, line brakes, start of insert

" Indent and TAB settings
set smartindent " add indentation for C-like languages after, e.g., an '{' or 'if'. Works on top of autoindent.

set tabstop=4 " the display width of a tab character in columns
set shiftwidth=4 " number of spaces to use for each autoindent step
set expandtab " use space characters instead of tabs
set softtabstop=4 " number of spaces that a <Tab> counts for while performing editing
set smarttab

" Natural split opening
set splitbelow
set splitright

" Folding for common languages
autocmd FileType c,cpp setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
autocmd FileType vim setlocal foldmethod=marker 
set foldlevelstart=99 " No folding upon opening file

" }}}

" FILE BROWSING ---------------------------------------------------------- {{{

" File Browsing tweaks
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
autocmd FileType netrw let g:netrw_list_hide=netrw_gitignore#Hide()
autocmd FileType netrw let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" }}}

" CLIPBOARD  ------------------------------------------------------------- {{{

set clipboard+=unnamedplus

" WAYLAND workaround for vim only
" clipboard support using wl-clipboard utility
" yanking only works in visual mode to + register
if !has('nvim')
    if !empty($WAYLAND_DISPLAY)
        if executable('wl-copy') && executable('wl-paste')
            xnoremap "+y y:call system("wl-copy", @")<CR>
            nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<CR>p
            nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<CR>p
        else
            echohl WarningMsg
            echom "Warning: wl-copy or wl-paste not found — clipboard mappings disabled."
            echohl None
        endif
    endif
endif

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Type jj to exit insert mode quickly.
inoremap jj <Esc>

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

" Ensure <C-L> also works in netrw context by remapping the refresh feature
autocmd FileType netrw nnoremap <buffer> <C-L> <C-W><C-L>
autocmd FileType netrw nnoremap <buffer> <leader>r :call netrw#LocalBrowseRefresh()<CR>

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center after jumping half-pages
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Set leader
let mapleader = " "

" <leader>l to stop highlight after search
nnoremap <silent> <leader>l :nohlsearch<CR>

" formatting
" clang-format binds to <leader>f
if has('python')
 nnoremap <leader>f :pyf ~/.vim-custom/clang-format.py<cr>
elseif has('python3')
 nnoremap <leader>f :py3f ~/.vim-custom/clang-format.py<cr>
endif

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Use the marker method of folding.
" This will enable code folding using {{{ as }}} markers (default marker).
" augroup filetype_vim
"     autocmd!
"     autocmd FileType vim setlocal foldmethod=marker 
" augroup END

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline nocursorcolumn
augroup END

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" Auto-clear highlighting on movement
autocmd CursorMoved * silent! :nohlsearch

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ ascii\/hex:%b\/0x%B\ row\/col:%l\/%c\ percent:%p%%

" Show the status on the second to last line.
set laststatus=2

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.

" }}}

" COLORSCHEME ------------------------------------------------------------ {{{

" vim specific colors
if !has('nvim')
    set termguicolors
    colorscheme catppuccin_mocha_brighter_line_nr
endif

" Make background transparent
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

" }}}

