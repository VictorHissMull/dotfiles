if !has('nvim')
    " Load vim defaults
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif "not nvim

" Make background transparent
highlight Normal guibg=NONE
highlight NonText guibg=NONE
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

