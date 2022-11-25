--# selene: allow(undefined_variable, unscoped_variables)
--# for list of lsp, linter, and formatter tools, see $XDG_CONFIG_HOME/packages

vim.cmd([[
filetype plugin indent off

let mapleader = "\<Space>"

" plugin netrw

let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

" plugin tmux tmux navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-g> :TmuxNavigatePrevious<cr>

" plugin print debug
nnoremap <silent> <leader>d :call print_debug#print_debug()<cr>

" plugin syntaxattr
nnoremap <silent> <leader>h :call SyntaxAttr#SyntaxAttr()<cr>

augroup AutoNetrwOnStart
    autocmd!
    let have_stdin = 0
    autocmd StdinReadPost * let have_stdin = 1
    autocmd VimEnter * if !(argc() + have_stdin) | Explore! | endif
augroup END

set tabstop=4
set virtualedit=block
set number
set nowrap
set autoread
set clipboard^=unnamed,unnamedplus
set diffopt+=vertical
set gdefault
set ignorecase
set inccommand=nosplit
set incsearch
set grepprg=rg\ --vimgrep\ --hidden
set updatetime=300
set scrolloff=5
set autowriteall
set noswapfile
set undodir=~/.cache/vimundo
set undofile
set nowritebackup
set nobackup
set spelllang=en_gb

autocmd FileType markdown            setlocal spell
autocmd FileType gitcommit           setlocal spell
autocmd FileType yaml                setlocal cursorcolumn
autocmd FileType yaml.docker-compose setlocal cursorcolumn

autocmd FileType yaml                setlocal comments=:#                              commentstring=#\ %s expandtab
autocmd FileType yaml.docker-compose setlocal comments=:#                              commentstring=#\ %s expandtab
autocmd FileType python              setlocal comments=b:#,fb:-                        commentstring=#\ %s
autocmd FileType go                  setlocal comments=s1:/*,mb:*,ex:*/,://            commentstring=//\ %s
autocmd FileType lua                 setlocal comments=:--                             commentstring=--%s
autocmd FileType vim                 setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"  commentstring=\"%s
autocmd FileType sql                 setlocal comments=s1:/*,mb:*,ex:*/,:--,://
autocmd FileType sh                  setlocal commentstring=#%s
autocmd FileType dockerfile          setlocal commentstring=#%s

augroup AutoCursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \     exec "normal g`\"" |
        \ endif
augroup END

augroup AutoOSC7Dir
    autocmd!
    autocmd BufEnter *
        \ call writefile([printf("\e\]7\;file://%s%s\e\\", hostname(), expand('%:p:h'))], '/dev/fd/2', 'b')
augroup END

" by Wouter Hanegraaff
augroup AutoEditGPGFile
    autocmd!
    autocmd BufReadPre,FileReadPre     *.gpg set viminfo=
    autocmd BufReadPre,FileReadPre     *.gpg set noswapfile noundofile nobackup
    autocmd BufReadPre,FileReadPre     *.gpg set bin
    autocmd BufReadPre,FileReadPre     *.gpg let ch_save = &cmdheight | set cmdheight=2
    autocmd BufReadPost,FileReadPost   *.gpg '[,']!gpg --decrypt 2>/dev/null
    autocmd BufReadPost,FileReadPost   *.gpg set nobin
    autocmd BufReadPost,FileReadPost   *.gpg let &cmdheight = ch_save | unlet ch_save
    autocmd BufReadPost,FileReadPost   *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    autocmd BufWritePre,FileWritePre   *.gpg '[,']!gpg --default-recipient-self --armor --encrypt 2>/dev/null
    autocmd BufWritePost,FileWritePost *.gpg undo
augroup END

autocmd TextYankPost * silent! lua vim.highlight.on_yank()

" completion
set completeopt=menu,menuone,noselect
set shortmess=filnxtToOFAc

" oops
command! Q quit
command! QA qall
command! Qa qall
command! W write
command! WA wall
command! Wa wall
command! WQ wq
command! Wq wq
command! WQa wqall
command! Wqa wqall
command! VS vsplit
command! Vs vsplit

" leader
nnoremap          <leader>bb mzggO#!/usr/bin/env bash<esc>o<esc>`z
nnoremap          <leader>bp mzggO#!/usr/bin/env python3<esc>o<esc>`z
nnoremap          <leader>r  :write<cr>:!clear && %:p<cr>
nnoremap          <leader>x  :write<cr>:!chmod +x %:p<cr><cr>
nnoremap          <leader>n  :set hlsearch!<cr>
nnoremap          <leader>l  :set list!<cr>
nnoremap          <leader>p  :set spell!<cr>
nnoremap          <leader>s  :%s/\<<c-r><c-w>\>/<c-r><c-w>/c<c-f>$F/
nnoremap          <leader>/  :echo expand('%:p')<cr>
nnoremap <expr>   <leader>t  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/'
nnoremap <expr>   <leader>y  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/hippl_'

" better
nnoremap Y y$
vnoremap yP yP

vnoremap u :OSCYank<cr>

" disable command hist
nnoremap Q <nop>

" easy split / quit
nnoremap <enter>       :vsplit<cr><c-w>w
nnoremap <s-enter>     :split<cr><c-w>w
nnoremap s             :write<enter>
nnoremap <silent> <c-[> <cmd>call CloseIfSaved()<cr>
nnoremap <silent> q     <cmd>call CloseIfSaved()<cr>

function! CloseIfSaved() abort
    if !&modified
        exec ":quit"
    endif
endfunction

" load current word or selection to cgn
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<cr>cgn
xnoremap <silent> s* "sy:let @/=@s<cr>cgn

nnoremap <up>    :resize -2<cr>
nnoremap <down>  :resize +2<cr>
nnoremap <left>  :vertical resize +2<cr>
nnoremap <right> :vertical resize -2<cr>

nnoremap [p :cprevious<cr>
nnoremap ]p :cnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [o :bprevious<cr>
nnoremap ]o :bnext<cr>
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>

nnoremap \]\] :cclose<cr>

" copy above / below
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" alternative escaping
inoremap jj <esc>
]])

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local cmp = require("cmp")
local cmplsp = require("cmp_nvim_lsp")
local sqlsp = require("sqls")
local nullls = require("null-ls")
local inlayhints = require("lsp-inlayhints")
local dap = require("dap")
local tscontext = require("treesitter-context")
local tsconfigs = require("nvim-treesitter.configs")

vim.diagnostic.config({ virtual_text = false })

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "tmux" },
	}),
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<c-x><c-o>"] = cmp.mapping.complete(),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-p>"] = cmp.mapping.select_prev_item(),
		["<c-n>"] = cmp.mapping.select_next_item(),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<c-e>"] = cmp.mapping.close(),
	},
	experimental = {
		ghost_text = { hl_group = "LineNr" },
	},
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "tmux" },
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "tmux" },
		{ name = "cmdline" },
	}),
})

vim.cmd([[
imap <expr> <tab>   vsnip#jumpable(1)  ? '<plug>(vsnip-jump-next)' : '<tab>'
smap <expr> <tab>   vsnip#jumpable(1)  ? '<plug>(vsnip-jump-next)' : '<tab>'
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<s-tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<plug>(vsnip-jump-prev)' : '<s-tab>'
]])

inlayhints.setup({
	inlay_hints = {
		parameter_hints = {
			prefix = "",
			separator = " ",
			remove_colon_start = true,
		},
		type_hints = {
			-- type and other hints
			show = true,
			prefix = "",
			separator = " ",
			remove_colon_start = true,
			remove_colon_end = truese,
		},
		labels_separator = " ",
		only_current_line = true,
	},
})

-- when using pylint or pyright, make sure we're in the right venv. eg
-- $ source $PYTHON_VENVS_DIR/<venv>/bin/activate.fish
-- $ pip install -r requirements-dev.txt .
-- $ which pylint
-- $ which pyright

local capabilities = cmplsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local format_augroup = vim.api.nvim_create_augroup("LSPFormatting", {})
local function format_please(client, buffer)
	if not client.supports_method("textDocument/formatting") then
		return
	end

	vim.api.nvim_clear_autocmds({
		group = format_augroup,
		buffer = buffer,
	})
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_augroup,
		buffer = buffer,
		callback = function()
			vim.lsp.buf.format({ timeout_ms = 5000 })
		end,
	})
end

local function add_inlay_hints(client, buffer)
	inlayhints.on_attach(client, buffer)
end

lspconfig.pyright.setup({
	capabilities = capabilities,
	settings = {
		python = {
			analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace" },
			venvPath = os.getenv("PYTHON_VENVS_DIR"),
		},
	},
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = add_inlay_hints,
	settings = {
		gopls = {
			experimentalPostfixCompletions = true,
			usePlaceholders = true,
			completeUnimported = true,
			deepCompletion = true,
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
		},
	},
})

lspconfig.sqls.setup({
	capabilities = capabilities,
	cmd = { "sqls", "-config", ".sqls.yml" },
	on_attach = function(client, buff_num)
		sqlsp.on_attach(client, buff_num)
	end,
})
vim.cmd([[
nnoremap <silent> <leader>qq Vip:SqlsExecuteQuery<cr>
vnoremap <silent> <leader>qq Vip:SqlsExecuteQuery<cr>
nnoremap <silent> <leader>qs :SqlsShowSchemas<cr>
]])

lspconfig.bashls.setup({
	capabilities = capabilities,
})

lspconfig.volar.setup({
	capabilities = capabilities,
	root_dir = util.root_pattern("vite.config.js", "shims-vue.d.ts"),
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	root_dir = util.root_pattern("tailwind.config.js"),
})

lspconfig.denols.setup({
	capabilities = capabilities,
	root_dir = util.root_pattern("deno.json"),
	single_file_support = false,
})

lspconfig.tsserver.setup({
	capabilities = capabilities,
	root_dir = util.root_pattern("tsconfig.json", "jsconfig.json"),
})

lspconfig.jdtls.setup({
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = function(client, buffer)
		format_please(client, buffer)
		add_inlay_hints(client, buffer)
	end,
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = format_please,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = format_please,
})

vim.cmd([[
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga    :<c-u>lua vim.lsp.buf.range_code_action()<cr>
nnoremap <silent> gt    <cmd>lua vim.diagnostic.setqflist()<cr>
inoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> J     <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <silent> H     <cmd>lua vim.diagnostic.goto_prev()<cr>
nnoremap <silent> L     <cmd>lua vim.diagnostic.goto_next()<cr>
]])

nullls.setup({
	log = { enable = false },
	on_attach = format_please,
	sources = {
		nullls.builtins.formatting.black,
		nullls.builtins.formatting.fish_indent,
		nullls.builtins.formatting.markdownlint.with({ extra_args = { "--disable", "MD014" } }),
		nullls.builtins.formatting.pg_format.with({ extra_args = { "--keyword-case", 1, "--type-case", 1 } }),
		nullls.builtins.formatting.prettierd,
		nullls.builtins.formatting.shfmt.with({ extra_args = { "-i", 4, "-bn" } }),
		nullls.builtins.formatting.stylua,
		nullls.builtins.formatting.goimports,

		nullls.builtins.diagnostics.eslint_d,
		nullls.builtins.diagnostics.golangci_lint,
		nullls.builtins.diagnostics.hadolint.with({ extra_args = { "--ignore", "DL3018", "--ignore", "DL3008" } }),
		nullls.builtins.diagnostics.markdownlint,
		nullls.builtins.diagnostics.pylint,
		nullls.builtins.diagnostics.selene,
	},
})

local ts_highlight = {
	enable = true,
	use_languagetree = true,
	additional_vim_regex_highlighting = false,
}
local ts_indent = { enable = true }
local ts_incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "=",
		node_incremental = "=",
		node_decremental = "-",
		scope_incremental = "+",
	},
}

tsconfigs.setup({
	ensure_installed = "all",
	highlight = ts_highlight,
	indent = ts_indent,
	incremental_selection = ts_incremental_selection,
})

vim.cmd([[
set nofoldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]])

tscontext.setup({
	enable = true,
	throttle = true,
	max_lines = 0,
	patterns = {
		default = {
			"class",
			"function",
			"method",
		},
	},
})

vim.cmd([[
omap     m :<c-u>lua require('tsht').nodes()<cr>
xnoremap m :lua require('tsht').nodes()<cr>
]])

local dap_go = function(name, request, mode, conf)
	local base = {
		name = name,
		type = "go",
		request = request,
		mode = mode,

		host = "localhost",
		port = function()
			return vim.fn.input("port: ", "9901")
		end,
	}
	for k, v in pairs(conf) do
		base[k] = v
	end
	return base
end

dap.adapters.go = function(cb, config)
	return cb({ type = "server", port = config.port, host = config.host })
end

dap.configurations.go = {
	-- dlv debug --headless --listen=:9901 --accept-multiclient --api-version=2 main.go
	dap_go("delve remote attach", "attach", "remote", {
		substitutePath = { { from = "${workspaceFolder}", to = "/go/src/app" } },
	}),

	-- dlv dap --listen :9901
	dap_go("delve local debug", "launch", "debug", {
		program = "${file}",
		args = function()
			return vim.split(vim.fn.input("args: "), " ")
		end,
	}),

	-- dlv dap --listen :9901
	dap_go("delve local test", "launch", "test", {
		program = "${file}",
	}),

	-- dlv dap --listen :9901
	dap_go("delve local test package", "launch", "test", {
		program = "./${relativeFileDirname}",
		args = function()
			return vim.split(vim.fn.input("args: "), " ")
		end,
	}),
}

vim.cmd([[
nnoremap <bs><bs>     <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <bs><bs><bs> <cmd>lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<cr>
nnoremap <bs>9        <cmd>lua require'dap'.stop()<cr>
nnoremap <bs>0        <cmd>lua require'dap'.continue()<cr>
nnoremap <bs>=        <cmd>lua require'dap'.step_into()<cr>
nnoremap <bs>==       <cmd>lua require'dap'.step_out()<cr>
nnoremap <bs>-        <cmd>lua require'dap'.step_over()<cr>
nnoremap <bs>[        <cmd>lua require'dap'.up()<cr>
nnoremap <bs>]        <cmd>lua require'dap'.down()<cr>
nnoremap <bs>#        <cmd>lua require'dap'.repl.open()<cr>
nnoremap <bs>1        <cmd>lua require'dap'.run_last()<cr>
]])
