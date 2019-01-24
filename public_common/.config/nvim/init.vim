" set dein helper paths
let s:cache_home = empty($XDG_CACHE_HOME) 
    \ ? expand('~/.cache')
    \ : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

" start dein
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    " dein
    call dein#add(s:dein_repo_dir)
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
    " getting around
    call dein#add('mhinz/vim-startify')
    call dein#add('junegunn/fzf.vim')
    call dein#add('tpope/vim-vinegar')
    call dein#add('christoomey/vim-tmux-navigator')
    " text operations
    call dein#add('tommcdo/vim-exchange')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    " panels
    call dein#add('majutsushi/tagbar',
        \ {'on_ft': ['go']})
    call dein#add('tpope/vim-fugitive')
    " appearance
    call dein#add('machakann/vim-highlightedyank')
    " langs
    call dein#add('fatih/vim-go',
        \ {'on_ft': ['go']})
    call dein#add('zchee/deoplete-go',
        \ {'on_ft': ['go']})
    call dein#add('posva/vim-vue',
        \ {'on_ft': ['vue', 'js']})
    call dein#end()
    call dein#save_state()
endif
