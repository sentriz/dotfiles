--# selene: allow(undefined_variable, unscoped_variables)
--# for list of lsp, linter, and formatter tools, see $XDG_CONFIG_HOME/packages

vim.loader.enable()

vim.cmd([[
let mapleader = "\<Space>"

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

augroup AutoNetrwOnStart
    autocmd!
    let had_q = index(v:argv, '-q') >= 0
    let have_stdin = 0
    autocmd StdinReadPost * let have_stdin = 1
    autocmd VimEnter * if !(argc() + have_stdin + had_q) | Explore! | endif
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

augroup AutoCursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if &ft != 'netrw' && &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \     exec "normal g`\"" |
        \ endif
augroup END

augroup AutoOSC7Dir
    autocmd!
    autocmd BufEnter *
        \ call writefile([printf("\e\]7\;file://%s%s\e\\", hostname(), expand('%:p:h'))], '/dev/fd/2', 'b')
augroup END

" window title
set title titlestring=%(%{expand(\"%:~:.:h\")}%)/%t\ vim

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
nnoremap        <leader>b        mzggO#!/usr/bin/env bash<esc>o<esc>`z
nnoremap        <leader><leader> za
nnoremap        <leader>n        :set hlsearch!<cr>
nnoremap        <leader>l        :set list!<cr>
nnoremap        <leader>p        :set spell!<cr>
nnoremap        <leader>s        :%s/\<<c-r><c-w>\>/<c-r><c-w>/c<c-f>$F/
nnoremap        <leader>/        :echo expand('%:p')<cr>
nnoremap <expr> <leader>t        ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/'
nnoremap <expr> <leader>y        ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/hippl_'

" better
nnoremap Y y$
vnoremap yP yP

" don't move when * search
nnoremap * *``

" visual replace without yank https://superuser.com/a/321726
vnoremap p "_dP

" easy normal mode for term
tnoremap <esc> <c-\><c-n>

" easy split / quit
nnoremap <enter>         :vsplit<cr><c-w>w
nnoremap <s-enter>       :split<cr><c-w>w
nnoremap s               :write<enter>
nnoremap <silent> <c-[>  <cmd>call CloseIfSaved()<cr>
nnoremap <silent> q      <cmd>call CloseIfSaved()<cr>
nnoremap Q               q

function! CloseIfSaved() abort
    if !&modified || len(win_findbuf(bufnr())) > 1
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

nnoremap [p :cprevious<cr>     " qf list
nnoremap ]p :cnext<cr>
nnoremap {P :cpfile<cr>        " qf list files (shift)
nnoremap }P :cnfile<cr>
nnoremap [o :bprevious<cr>     " buffer
nnoremap ]o :bnext<cr>
nnoremap {O :tabprevious<cr>   " tab (shift)
nnoremap }O :tabnext<cr>
nnoremap [q :colder<cr>        " list of qf lists
nnoremap ]q :cnewer<cr>

nnoremap \]\] :cclose<cr>

" copy above / below
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" alternative escaping
inoremap jj <esc>
]])

-- mini
require("mini.surround").setup()
require("mini.comment").setup()
require("mini.ai").setup()

local cmp = require("cmp")
local cmplsp = require("cmp_nvim_lsp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
		{ name = "tmux" },
	}),
	snippet = {
		expand = function(arg)
			vim.snippet.expand(arg.body)
		end,
	},
	mapping = {
		["<c-x><c-o>"] = cmp.mapping.complete(),
		["<c-space>"] = cmp.mapping.complete(),
		["<c-p>"] = cmp.mapping.select_prev_item(),
		["<c-n>"] = cmp.mapping.select_next_item(),
		["<cr>"] = cmp.mapping.confirm({ select = true }),
		["<c-e>"] = cmp.mapping.close(),
		["<tab>"] = vim.snippet.jump(1),
		["<s-tab>"] = vim.snippet.jump(-1),
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

-- when using pylint or pyright, make sure we're in the right venv. eg
-- $ source $PYTHON_VENVS_DIR/<venv>/bin/activate.fish
-- $ pip install -r requirements-dev.txt .
-- $ which pylint
-- $ which pyright

local capabilities = cmplsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local format_augroup = vim.api.nvim_create_augroup("LSPFormatting", {})
local function on_attach(client, buffer)
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
			if vim.g.noformat ~= nil then
				return
			end
			vim.lsp.buf.format({
				async = false,
				timeout_ms = 5000,
				filter = function(c)
					-- using goimports instead
					if c.name == "gopls" then
						return false
					end
					return true
				end,
			})
		end,
	})
end

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		python = {
			analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace" },
			venvPath = os.getenv("PYTHON_VENVS_DIR"),
		},
	},
})

lspconfig.gopls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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

lspconfig.bashls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.volar.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = util.root_pattern("vite.config.js", "vite.config.ts", "shims-vue.d.ts"),
})

lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = util.root_pattern("tailwind.config.js"),
})

lspconfig.denols.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = util.root_pattern("deno.json"),
	single_file_support = false,
})

lspconfig.ts_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = util.root_pattern("tsconfig.json", "jsconfig.json"),
	handlers = {
		-- pick the first response to a go to definition response. that way we go straight to the
		-- source definition without needing to choose from the type definition .d.ts file
		["textDocument/definition"] = function(err, result, ...)
			result = vim.tbl_islist(result) and result[1] or result
			vim.lsp.handlers["textDocument/definition"](err, result, ...)
		end,
	},
})

lspconfig.jdtls.setup({
	capabilities = capabilities,
})

lspconfig.clangd.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.dockerls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.diagnostic.config({ virtual_text = false })

vim.cmd([[
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga    :<c-u>lua vim.lsp.buf.code_action({range=nil})<cr>
nnoremap <silent> gt    <cmd>lua vim.diagnostic.setqflist()<cr>
inoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> gh    <cmd>lua vim.lsp.inlay_hint(0)<cr>
nnoremap <silent> H     <cmd>lua vim.diagnostic.goto_prev()<cr>
nnoremap <silent> J     <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> L     <cmd>lua vim.diagnostic.goto_next()<cr>
]])

local nullls = require("null-ls")

nullls.setup({
	log_level = "off",
	on_attach = on_attach,
	sources = {
		nullls.builtins.formatting.black,
		nullls.builtins.formatting.fish_indent,
		nullls.builtins.formatting.markdownlint.with({ extra_args = { "--disable", "MD014" } }),
		nullls.builtins.formatting.pg_format.with({ extra_args = { "--keyword-case", 1, "--type-case", 1 } }),
		nullls.builtins.formatting.prettierd,
		nullls.builtins.formatting.shfmt.with({ extra_args = { "-i", 4, "-bn" } }),
		nullls.builtins.formatting.stylua,
		nullls.builtins.formatting.goimports,

		nullls.builtins.diagnostics.hadolint.with({ extra_args = { "--ignore", "DL3018", "--ignore", "DL3008" } }),
		nullls.builtins.diagnostics.markdownlint,
		nullls.builtins.diagnostics.pylint,
		nullls.builtins.diagnostics.selene,
	},
})

-- treesitter incremental selection
local tsincremental = require("nvim-treesitter-incremental-selection")
tsincremental.setup({
	ignore_injections = false,
	loop_siblings = true,
	fallback = true,
	quiet = true,
})

vim.keymap.set("n", "=", tsincremental.init_selection)
vim.keymap.set("v", "=", tsincremental.increment_node)
vim.keymap.set("v", "-", tsincremental.decrement_node)

vim.keymap.set("v", "_", tsincremental.prev_sibling)
vim.keymap.set("v", "+", tsincremental.next_sibling)

-- treesitter parser name overrides
vim.treesitter.language.register("angular", { "htmlangular" })
vim.treesitter.language.register("bash", { "sh" })
vim.treesitter.language.register("commonlisp", { "lisp" })
vim.treesitter.language.register("diff", { "gitdiff" })
vim.treesitter.language.register("elixir", { "ex" })
vim.treesitter.language.register("git_config", { "gitconfig" })
vim.treesitter.language.register("git_rebase", { "gitrebase" })
vim.treesitter.language.register("haskell", { "hs" })
vim.treesitter.language.register("ini", { "confini", "dosini" })
vim.treesitter.language.register("javascript", { "javascriptreact", "ecma", "ecmascript", "jsx", "js" })
vim.treesitter.language.register("latex", { "tex" })
vim.treesitter.language.register("make", { "automake" })
vim.treesitter.language.register("markdown", { "pandoc" })
vim.treesitter.language.register("python", { "py", "gyp" })
vim.treesitter.language.register("ssh_config", { "sshconfig" })
vim.treesitter.language.register("typescript", { "ts" })

-- treesitter auto start
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

-- treesitter tscontext
local tscontext = require("treesitter-context")
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

-- treesitter folding
vim.cmd([[
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()
set foldlevel=99
set foldtext=FoldText()
function! FoldText()
  return getline(v:foldstart) . " ..."
endfunction
]])

local dap = require("dap")

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
