let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.nvim_lsp = v:true

let g:Illuminate_delay = 500

" category "meta"
" ~/.local/share/nvim/site/pack/meta/opt/
packadd! RRethy/vim-illuminate
packadd! christoomey/vim-tmux-navigator
packadd! hrsh7th/nvim-compe
packadd! inkarkat/SyntaxAttr.vim
packadd! machakann/vim-highlightedyank
packadd! mhartington/formatter.nvim
packadd! mkotha/conflict3
packadd! neovim/nvim-lsp
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
packadd! sentriz/vim-print-debug
packadd! tommcdo/vim-exchange
packadd! tpope/vim-abolish
packadd! tpope/vim-commentary
packadd! tpope/vim-repeat
packadd! tpope/vim-surround
packadd! wellle/targets.vim
