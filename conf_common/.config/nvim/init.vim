" define dein helper variables
let s:dein_dir = expand('~/.cache/dein')
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
    call dein#add('neoclide/coc.nvim', {'if': 'executable("node")'})
    " getting around
    call dein#add('tpope/vim-vinegar')
    call dein#add('christoomey/vim-tmux-navigator')
    " text operations
    call dein#add('tommcdo/vim-exchange')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-surround')
    call dein#add('wellle/targets.vim')
    call dein#add('tpope/vim-abolish')
    " misc
    call dein#add('machakann/vim-highlightedyank')
    call dein#add('majutsushi/tagbar', {'on_ft': 'go'})
    call dein#add('rhysd/committia.vim')
    call dein#add('romainl/vim-qf')
    call dein#add('atimholt/spiffy_foldtext')
    "
    call dein#end()
    call dein#save_state()
endif

if dein#is_sourced("vim-vinegar")
    let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'
endif

if dein#is_sourced("vim-tmux-navigator")
    let g:tmux_navigator_no_mappings = 1
    let g:tmux_navigator_save_on_switch = 1
endif

if dein#is_sourced("spiffy_foldtext")
    let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"
endif

" to remove old plugins
" call map(dein#check_clean(), "delete(v:val, 'rf')")
" call dein#recache_runtimepath()

" source the rest of the rc
exec 'source' . expand("~/.config/nvim/rc/appearance.vim")
exec 'source' . expand("~/.config/nvim/rc/auto_commands.vim")
exec 'source' . expand("~/.config/nvim/rc/improvements.vim")
exec 'source' . expand("~/.config/nvim/rc/mappings.vim")

if dein#is_sourced("coc.nvim")
    exec 'source' . expand("~/.config/nvim/rc/coc.vim")
endif

" enable filetype detection and plugin loading
filetype on
filetype plugin on
