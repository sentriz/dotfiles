--# selene: allow(undefined_variable, unscoped_variables)
--# for list of lsp, linter, and formatter tools, see $XDG_CONFIG_HOME/packages

vim.loader.enable()

vim.g.mapleader = " "

-- plugin: tmux navigator
vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 1

vim.keymap.set("n", "<c-k>", ":TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<c-j>", ":TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<c-h>", ":TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<c-l>", ":TmuxNavigateRight<cr>", { silent = true })
vim.keymap.set("n", "<c-g>", ":TmuxNavigatePrevious<cr>", { silent = true })

-- plugin: print debug
vim.keymap.set("n", "<leader>d", ":call print_debug#print_debug()<cr>", { silent = true })

-- auto start netrw when no files opened
local function setup_netrw_on_start()
	local had_q = vim.fn.index(vim.v.argv, "-q") >= 0
	local have_stdin = 0

	vim.api.nvim_create_autocmd("StdinReadPost", {
		callback = function()
			have_stdin = 1
		end,
	})

	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			if not (vim.fn.argc() + have_stdin + (had_q and 1 or 0) > 0) then
				vim.cmd("Explore!")
			end
		end,
	})
end

setup_netrw_on_start()

-- basic settings
vim.opt.tabstop = 4
vim.opt.virtualedit = "block"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.autoread = true
vim.opt.clipboard:prepend({ "unnamed", "unnamedplus" })
vim.opt.diffopt:append("vertical")
vim.opt.gdefault = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.updatetime = 300
vim.opt.scrolloff = 5
vim.opt.autowriteall = true
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.expand("~/.cache/vimundo")
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.spelllang = "en_gb"

-- filetype settings
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "gitcommit",
	command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "yaml",
	command = "setlocal cursorcolumn",
})

-- restore cursor position
vim.api.nvim_create_augroup("AutoCursorLastPosition", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = "AutoCursorLastPosition",
	callback = function()
		local ft = vim.bo.filetype
		local last_pos = vim.fn.line("'\"")
		if ft ~= "netrw" and ft ~= "gitcommit" and last_pos > 0 and last_pos <= vim.fn.line("$") then
			vim.cmd('normal! g`"')
		end
	end,
})

-- terminal integration: update directory
vim.api.nvim_create_augroup("AutoOSC7Dir", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	group = "AutoOSC7Dir",
	callback = function()
		local path = vim.fn.expand("%:p:h")
		local hostname = vim.fn.hostname()
		local osc7_string = string.format("\027]7;file://%s%s\027\\", hostname, path)
		local stderr = io.open("/dev/fd/2", "w")
		if stderr then
			stderr:write(osc7_string)
			stderr:close()
		end
	end,
})

-- window title
vim.opt.title = true
vim.opt.titlestring = '%(%{expand("%:~:.:h")}%)/%t vim'

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- completion settings
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess = "filnxtToOFAc"

-- oops (typo corrections)
vim.api.nvim_create_user_command("Q", "quit", {})
vim.api.nvim_create_user_command("QA", "qall", {})
vim.api.nvim_create_user_command("Qa", "qall", {})
vim.api.nvim_create_user_command("W", "write", {})
vim.api.nvim_create_user_command("WA", "wall", {})
vim.api.nvim_create_user_command("Wa", "wall", {})
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("WQa", "wqall", {})
vim.api.nvim_create_user_command("Wqa", "wqall", {})
vim.api.nvim_create_user_command("VS", "vsplit", {})
vim.api.nvim_create_user_command("Vs", "vsplit", {})

-- leader mappings
vim.keymap.set("n", "<leader>b", "mzggO#!/usr/bin/env bash<esc>o<esc>`z")
vim.keymap.set("n", "<leader><leader>", "za")
vim.keymap.set("n", "<leader>n", ":set hlsearch!<cr>")
vim.keymap.set("n", "<leader>l", ":set list!<cr>")
vim.keymap.set("n", "<leader>p", ":set spell!<cr>")
vim.keymap.set("n", "<leader>s", ":%s/\\<<c-r><c-w>\\>/<c-r><c-w>/c<c-f>$F/")
vim.keymap.set("n", "<leader>/", ":echo expand('%:p')<cr>")
vim.keymap.set("n", "<leader>t", function()
	return ":tabnew " .. vim.fn.expand("$PROJECTS_DIR") .. "/"
end, { expr = true })

-- better defaults
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("v", "yP", "yP")

-- don't move cursor on * search
vim.keymap.set("n", "*", "*``")

-- visual replace without yank https://superuser.com/a/321726
vim.keymap.set("v", "p", '"_dP')

-- easy normal mode for terminal
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

-- easy split / quit
function CloseIfSaved()
	if not vim.bo.modified or #vim.fn.win_findbuf(vim.fn.bufnr()) > 1 then
		vim.cmd("silent! quit")
	end
end

vim.keymap.set("n", "<enter>", ":vsplit<cr><c-w>w")
vim.keymap.set("n", "<s-enter>", ":split<cr><c-w>w")
vim.keymap.set("n", "s", ":write<enter>")
vim.keymap.set("n", "<c-[>", CloseIfSaved, { silent = true })
vim.keymap.set("n", "q", CloseIfSaved, { silent = true })
vim.keymap.set("n", "Q", "q")

-- window resizing with arrows
vim.keymap.set("n", "<up>", ":resize -2<cr>")
vim.keymap.set("n", "<down>", ":resize +2<cr>")
vim.keymap.set("n", "<left>", ":vertical resize +2<cr>")
vim.keymap.set("n", "<right>", ":vertical resize -2<cr>")

-- navigation mappings
vim.keymap.set("n", "[p", ":cprevious<cr>") -- qf list
vim.keymap.set("n", "]p", ":cnext<cr>")
vim.keymap.set("n", "{P", ":cpfile<cr>") -- qf list files (shift)
vim.keymap.set("n", "}P", ":cnfile<cr>")
vim.keymap.set("n", "[o", ":bprevious<cr>") -- buffer
vim.keymap.set("n", "]o", ":bnext<cr>")
vim.keymap.set("n", "{O", ":tabprevious<cr>") -- tab (shift)
vim.keymap.set("n", "}O", ":tabnext<cr>")
vim.keymap.set("n", "[q", ":colder<cr>") -- list of qf lists
vim.keymap.set("n", "]q", ":cnewer<cr>")

-- toggle quickfix list
local function toggle_quickfix()
	local windows = vim.fn.getwininfo()
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end

vim.keymap.set("n", "]]", toggle_quickfix)

-- copy character above/below cursor
vim.keymap.set("i", "<c-y>", function()
	local line = vim.fn.line(".") - 1
	local col = vim.fn.virtcol(".")
	local pattern = string.format("\\%%%dv\\%%(%s\\|.\\)", col, "\\k\\+")
	return vim.fn.matchstr(vim.fn.getline(line), pattern)
end, { expr = true })
vim.keymap.set("i", "<c-e>", function()
	local line = vim.fn.line(".") + 1
	local col = vim.fn.virtcol(".")
	local pattern = string.format("\\%%%dv\\%%(%s\\|.\\)", col, "\\k\\+")
	return vim.fn.matchstr(vim.fn.getline(line), pattern)
end, { expr = true })

-- alternative escape
vim.keymap.set("i", "jj", "<esc>")

-- mini plugins
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

-- lsp
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

-- when using pylint or pyright, make sure we're in the right venv. eg
-- $ source $PYTHON_VENVS_DIR/<venv>/bin/activate.fish
-- $ pip install -r requirements-dev.txt .
-- $ which pylint
-- $ which pyright

vim.lsp.enable("pyright", {
	settings = {
		python = {
			analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace" },
			venvPath = os.getenv("PYTHON_VENVS_DIR"),
		},
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("gopls", {
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
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("bashls", { capabilities = capabilities, on_attach = on_attach })

vim.lsp.enable("vue_ls", {
	root_markers = { "vite.config.js", "vite.config.ts", "shims-vue.d.ts" },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("tailwindcss", {
	root_markers = { "tailwind.config.js" },
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("denols", {
	root_markers = { "deno.json" },
	single_file_support = false,
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("ts_ls", {
	root_markers = { "tsconfig.json", "jsconfig.json" },
	handlers = {
		["textDocument/definition"] = function(err, result, ...)
			result = vim.tbl_islist(result) and result[1] or result
			vim.lsp.handlers["textDocument/definition"](err, result, ...)
		end,
	},
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.lsp.enable("jdtls", { capabilities = capabilities })
vim.lsp.enable("clangd", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.enable("dockerls", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.enable("rust_analyzer", { capabilities = capabilities, on_attach = on_attach })

-- lsp diagnostics
vim.diagnostic.config({ virtual_text = false })

-- lsp document highlight
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/documentHighlight") then
				vim.lsp.buf.document_highlight()
				break
			end
		end
	end,
})
vim.api.nvim_create_autocmd("CursorHoldI", {
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/documentHighlight") then
				vim.lsp.buf.document_highlight()
				break
			end
		end
	end,
})
vim.api.nvim_create_autocmd("CursorMoved", {
	callback = function()
		vim.lsp.buf.clear_references()
	end,
})

-- lsp mappings
vim.keymap.set("n", "gd", vim.lsp.buf.declaration, { silent = true })
vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, { silent = true })
vim.keymap.set("n", "gD", vim.lsp.buf.implementation, { silent = true })
vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { silent = true })
vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, { silent = true })
vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, { silent = true })
vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { silent = true })
vim.keymap.set("v", "ga", function()
	vim.lsp.buf.code_action({ range = nil })
end, { silent = true })
vim.keymap.set("n", "gt", vim.diagnostic.setqflist, { silent = true })
vim.keymap.set("i", "<c-s>", vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set("n", "gh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { silent = true })
vim.keymap.set("n", "H", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "J", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true })
vim.keymap.set("n", "L", vim.diagnostic.goto_next, { silent = true })

-- nullls
local nullls = require("null-ls")
nullls.setup({
	log_level = "off",
	on_attach = on_attach,
	sources = {
		nullls.builtins.formatting.black,
		nullls.builtins.formatting.clang_format,
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

-- treesitter context
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
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldtext = ""

-- dap
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

-- dap keymaps
vim.keymap.set("n", "<bs><bs>", dap.toggle_breakpoint)
vim.keymap.set("n", "<bs><bs><bs>", function()
	dap.set_breakpoint(vim.fn.input("condition: "))
end)
vim.keymap.set("n", "<bs>9", dap.stop)
vim.keymap.set("n", "<bs>0", dap.continue)
vim.keymap.set("n", "<bs>=", dap.step_into)
vim.keymap.set("n", "<bs>==", dap.step_out)
vim.keymap.set("n", "<bs>-", dap.step_over)
vim.keymap.set("n", "<bs>[", dap.up)
vim.keymap.set("n", "<bs>]", dap.down)
vim.keymap.set("n", "<bs>#", dap.repl.open)
vim.keymap.set("n", "<bs>1", dap.run_last)
