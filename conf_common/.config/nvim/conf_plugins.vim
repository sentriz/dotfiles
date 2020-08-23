let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1

let g:completion_enable_auto_popup = 1
let g:completion_enable_auto_paren = 1
let g:completion_enable_auto_hover = 0

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0

" category "meta"
" ~/.local/share/nvim/site/pack/meta/opt/
packadd! Lokaltog/vim-monotone
packadd! christoomey/vim-tmux-navigator
packadd! inkarkat/SyntaxAttr.vim
packadd! machakann/vim-highlightedyank
packadd! neovim/nvim-lsp
packadd! nvim-lua/completion-nvim
packadd! nvim-lua/diagnostic-nvim
packadd! rhysd/committia.vim
packadd! romainl/vim-qf
packadd! roxma/vim-hug-neovim-rpc
packadd! sheerun/vim-polyglot

" category "look"
" ~/.local/share/nvim/site/pack/look/opt/
packadd! Lokaltog/vim-monotone
packadd! atimholt/spiffy_foldtext
packadd! tpope/vim-vinegar

" category "text"
" ~/.local/share/nvim/site/pack/text/opt/
packadd! tommcdo/vim-exchange
packadd! tpope/vim-abolish
packadd! tpope/vim-commentary
packadd! tpope/vim-repeat
packadd! tpope/vim-surround
packadd! wellle/targets.vim
packadd! sentriz/vim-print-debug
