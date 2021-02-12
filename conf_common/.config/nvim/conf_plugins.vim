let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

let g:completion_enable_auto_hover = 0
let g:completion_enable_auto_signature = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_items_priority = {
            \ 'EnumMember': 11,
            \ 'Field':      11,
            \ 'Constant':   11,
            \ 'Variables':  11,
            \ 'Method':     10,
            \ 'Property':   7,
            \ 'Function':   7,
            \ 'Variable':   7,
            \ 'Interfaces': 5,
            \ 'Class':      5,
            \ 'Keyword':    4,
            \ 'UltiSnips':  1,
            \ 'File':       1,
            \ }

let g:Illuminate_delay = 500

" category "meta"
" ~/.local/share/nvim/site/pack/meta/opt/
packadd! RRethy/vim-illuminate
packadd! christoomey/vim-tmux-navigator
packadd! inkarkat/SyntaxAttr.vim
packadd! machakann/vim-highlightedyank
packadd! mhartington/formatter.nvim
packadd! neovim/nvim-lsp
packadd! nvim-lua/completion-nvim
packadd! rhysd/committia.vim
packadd! romainl/vim-qf
packadd! sheerun/vim-polyglot
packadd! nanotee/sqls.nvim

" category "look"
" ~/.local/share/nvim/site/pack/look/opt/
packadd! Lokaltog/vim-monotone
packadd! atimholt/spiffy_foldtext
packadd! tpope/vim-vinegar

" category "text"
" ~/.local/share/nvim/site/pack/text/opt/
packadd! sentriz/vim-print-debug
packadd! tommcdo/vim-exchange
packadd! tpope/vim-abolish
packadd! tpope/vim-commentary
packadd! tpope/vim-repeat
packadd! tpope/vim-surround
packadd! wellle/targets.vim
