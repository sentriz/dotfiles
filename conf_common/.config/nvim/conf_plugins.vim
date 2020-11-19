let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

" category "meta"
" ~/.local/share/nvim/site/pack/meta/opt/
packadd! christoomey/vim-tmux-navigator
packadd! inkarkat/SyntaxAttr.vim
packadd! machakann/vim-highlightedyank
packadd! neovim/nvim-lsp
packadd! nvim-lua/popup.nvim
packadd! nvim-lua/plenary.nvim
packadd! nvim-lua/telescope.nvim
packadd! rhysd/committia.vim
packadd! romainl/vim-qf
packadd! sheerun/vim-polyglot

" category "look"
" ~/.local/share/nvim/site/pack/look/opt/
packadd! Lokaltog/vim-monotone
packadd! atimholt/spiffy_foldtext
packadd! tpope/vim-vinegar

" category "text"
" ~/.local/share/nvim/site/pack/text/opt/
packadd! mattn/emmet-vim
packadd! sentriz/vim-print-debug
packadd! tommcdo/vim-exchange
packadd! tpope/vim-abolish
packadd! tpope/vim-commentary
packadd! tpope/vim-repeat
packadd! tpope/vim-surround
packadd! wellle/targets.vim
