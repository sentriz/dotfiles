let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

let g:Illuminate_delay = 500

" category "meta"
" ~/.local/share/nvim/site/pack/meta/opt/
packadd! RRethy/vim-illuminate
packadd! christoomey/vim-tmux-navigator
packadd! machakann/vim-highlightedyank
packadd! mhartington/formatter.nvim
packadd! mkotha/conflict3
packadd! neovim/nvim-lsp
packadd! rhysd/committia.vim
packadd! romainl/vim-qf
packadd! nvim-treesitter/nvim-treesitter
packadd! nvim-treesitter/nvim-treesitter-textobjects

" category "look"
" ~/.local/share/nvim/site/pack/look/opt/
packadd! Lokaltog/vim-monotone
packadd! tpope/vim-vinegar

" category "text"
" ~/.local/share/nvim/site/pack/text/opt/
packadd! sentriz/vim-print-debug
packadd! tpope/vim-abolish
packadd! tpope/vim-commentary
packadd! tpope/vim-repeat
packadd! tpope/vim-surround
