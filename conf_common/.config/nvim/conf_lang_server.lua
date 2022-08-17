--# selene: allow(undefined_variable, unscoped_variables)
--# for list of lsp, linter, and formatter tools, see $XDG_CONFIG_HOME/packages

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")
local cmp = require("cmp")
local sqlsp = require("sqls")
local nullls = require("null-ls")

vim.diagnostic.config({ virtual_text = false })

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
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

cmp.setup.cmdline("/", {
	sources = cmp.config.sources({
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "tmux" },
	}, {
		{ name = "cmdline" },
	}),
})

-- when using pylint or pyright, make sure we're in the right venv. eg
-- $ source $PYTHON_VENVS_DIR/<venv>/bin/activate.fish
-- $ pip install -r requirements-dev.txt .
-- $ which pylint
-- $ which pyright

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

lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = { autoSearchPaths = true, useLibraryCodeForTypes = true, diagnosticMode = "workspace" },
			venvPath = os.getenv("PYTHON_VENVS_DIR"),
		},
	},
})

lspconfig.gopls.setup({
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			deepCompletion = true,
		},
	},
})

lspconfig.sqls.setup({
	cmd = { "sqls", "-config", ".sqls.yml" },
	on_attach = function(client, buff_num)
		sqlsp.on_attach(client, buff_num)
	end,
})

lspconfig.bashls.setup({})
lspconfig.volar.setup({ root_dir = util.root_pattern("vite.config.js", "shims-vue.d.ts") })
lspconfig.tailwindcss.setup({ root_dir = util.root_pattern("tailwind.config.js") })
lspconfig.denols.setup({ root_dir = util.root_pattern("deno.json"), single_file_support = false })
lspconfig.tsserver.setup({ root_dir = util.root_pattern("tsconfig.json", "jsconfig.json") })
lspconfig.jdtls.setup({})

lspconfig.clangd.setup({ on_attach = format_please })
lspconfig.dockerls.setup({ on_attach = format_please })
lspconfig.rust_analyzer.setup({ on_attach = format_please })

nullls.setup({
	log = { enable = false },
	on_attach = format_please,
	sources = {
		nullls.builtins.formatting.black,
		nullls.builtins.formatting.fish_indent,
		nullls.builtins.formatting.markdownlint,
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
		nullls.builtins.diagnostics.shellcheck,
	},
})
