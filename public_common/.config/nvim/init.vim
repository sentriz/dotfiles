" define dein helper variables
let s:cache_home = empty($XDG_CACHE_HOME) 
    \ ? expand('~/.cache')
    \ : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" append dein repo to runtimepath
let &runtimepath = &runtimepath . ',' . s:dein_repo_dir

" load dein plugins
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#add(s:dein_repo_dir)
    " meta
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
    call dein#add('wellle/targets.vim')
    call dein#add('rhysd/clever-f.vim')
    " panels
    call dein#add('majutsushi/tagbar', {'on_ft': 'go'})
    call dein#add('tpope/vim-fugitive')
    " appearance
    call dein#add('machakann/vim-highlightedyank')
    call dein#add('mhinz/vim-signify')
    " langs
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('ambv/black', {'on_ft': 'python'})
    call dein#add('fatih/vim-go', {'on_ft': 'go'})
    call dein#add('zchee/deoplete-go', {'on_ft': 'go'})
    call dein#add('posva/vim-vue', {'on_ft': 'vue'})
    " misc
    call dein#add('rhysd/committia.vim')
    call dein#end()
    call dein#save_state()
endif

" source the rest of the rc
for rc_path in split(globpath('~/.config/nvim/rc/', '*.vim'), '\n')
    execute 'source' rc_path
endfor

" enable filetype detection and plugin loading
filetype on
filetype plugin on

" apply colorscheme
syntax on
colorscheme custom
