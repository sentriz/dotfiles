-- requires https://github.com/sentriz/nvim-lsp-compose

-- lang servers:
--     bash       npm install -g bash-language-server
--     c          yay -S clang
--     dockerfile npm install -g dockerfile-language-server-nodejs
--     go         go get -u golang.org/x/tools/gopls@latest
--     python     npm install -g pyright
--     js, ts     npm install -g typescript typescript-language-server
--     svelte     npm install -g svelte svelte-language-server
--     tailwind   yay -S vscode-tailwindcss-language-server-bin

-- formatters:
--     prettierd            npm install -g https://github.com/fsouza/prettierd
--     prettier go template npm install -g prettier prettier-plugin-go-template
--     prettier svelte      npm install -g prettier prettier-plugin-svelte svelte
--     goimports            go get -u golang.org/x/tools/cmd/goimports
--     clang-format         yay -S clang
--     black                pip install --user black
--     stylua               https://github.com/JohnnyMorganz/StyLua/releases
--     pg_format            https://github.com/darold/pgFormatter
--     pandoc               yay -S pandoc-bin

-- linters:
--     shellcheck   yay -S shellcheck-bin
--     eslint_d     npm install -g eslint_d
--     pylint       pip install --user pylint
--     hadolint     yay -S hadolint-bin
--     markdownlint npm install -g markdownlint-cli

local lsp = require("lspconfig")
local configs = require("lspconfig/configs")
local util = require("lspconfig/util")
local c = require("nvim-lsp-compose")
local compe = require("compe")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = false,
	signs = true,
	update_in_insert = false,
})

local tailwind_intellisense = c.server({
	cmd = { "tailwindcss-language-server", "--stdio" },
	root_dir = util.root_pattern("tailwind.config.js", "package.json", ".git"),
	settings = {
		tailwindCSS = {
			validate = true,
			lint = {
				cssConflict = "warning",
				invalidApply = "error",
				invalidScreen = "error",
				invalidVariant = "error",
				invalidConfigPath = "error",
				invalidTailwindDirective = "error",
			},
		},
	},
	init_options = {
		userLanguages = {},
	},
})

local bash_ls = c.server({
	cmd = { "bash-language-server", "start" },
	root_dir = util.path.dirname,
})

local gopls = c.server({
	cmd = { "gopls" },
	root_dir = util.root_pattern("go.mod", ".git"),
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			deepCompletion = true,
			staticcheck = true,
			analyses = { unreachable = true, unusedparams = true },
		},
	},
})

local clangd = c.server({
	cmd = {
		"clangd",
		"--background-index",
		"--pch-storage=memory",
		"--clang-tidy",
	},
	root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
	capabilities = { textDocument = { completion = { editsNearCursor = true } } },
})

local docker_ls = c.server({
	cmd = { "docker-langserver", "--stdio" },
	root_dir = util.root_pattern("Dockerfile"),
})

local pyright = c.server({
	cmd = { "pyright-langserver", "--stdio" },
	root_dir = util.root_pattern("requirements.txt", "pyproject.toml", "Pipfile", ".git"),
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
})

local ts_server = c.server({
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
})

local efm = c.server({
	cmd = { "efm-langserver" },
	init_options = { v = 1 },
	settings = { rootMarkers = { ".git" }, languages = {} },
	root_dir = function(filename)
		return util.root_pattern(".git")(filename) or util.path.dirname(filename)
	end,
})

local pyright_organise_imports = c.action(function(client, buff_num)
	local params = {
		command = "pyright.organizeimports",
		arguments = { vim.uri_from_bufnr(buff_num) },
	}
	client.request_sync("workspace/executeCommand", params, 2000)
end)

local ts_server_organise_imports = c.action(function(client, buff_num)
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	client.request("workspace/executeCommand", params, 1000, buff_num)
end)

local gopls_organise_imports = c.action(function(client, buff_num)
	local context = { source = { organizeImports = true } }
	vim.validate({ context = { context, "t", true } })

	local params = vim.lsp.util.make_range_params()
	params.context = context

	local resp = client.request_sync("textDocument/codeAction", params, 1000, buff_num)
	if not resp then
		return
	end

	for _, v in next, resp, nil do
		if v and v[1].edit then
			vim.lsp.util.apply_workspace_edit(v[1].edit)
		end
	end
end)

local prettier = c.formatter("prettier", "--stdin-filepath", "${INPUT}")
local prettierd = c.formatter("prettierd", "${INPUT}")
local gofmt = c.formatter("gofmt")
local goimports = c.formatter("goimports")
local clang_format = c.formatter("clang-format", "--assume-filename", "${INPUT}", "-")
local black = c.formatter("black", "--quiet", "-")
local shfmt = c.formatter("shfmt", "-i", 4, "-bn", "-")
local stylua = c.formatter("stylua", "-")
local pg_format = c.formatter("pg_format", "--keyword-case", 1, "--type-case", 1)
local pandoc_markdown = c.formatter(
	"pandoc",
	"--from",
	"markdown",
	"--to",
	"gfm",
	"--standalone",
	"--preserve-tabs",
	"--tab-stop",
	2
)

local shellcheck = c.linter({
	lintSource = "shellcheck",
	lintCommand = "shellcheck --format gcc -",
	lintStdin = true,
	lintFormats = {
		"%f:%l:%c: %trror: %m",
		"%f:%l:%c: %tarning: %m",
		"%f:%l:%c: %tote: %m",
	},
})

local eslint_d = c.linter({
	lintSource = "eslint",
	lintCommand = "eslint_d --format visualstudio --stdin --stdin-filename ${INPUT}",
	lintStdin = true,
	lintIgnoreExitCode = true,
	lintFormats = {
		"%f(%l,%c): %tarning %m",
		"%f(%l,%c): %rror %m",
	},
})

local hadolint = c.linter({
	lintSource = "hadolint",
	lintCommand = "hadolint --no-color -",
	lintStdin = true,
	lintIgnoreExitCode = true,
	lintFormats = {
		"%f:%l %m",
	},
})

local markdownlint = c.linter({
	lintSource = "markdownlint",
	lintCommand = "markdownlint --stdin",
	lintStdin = true,
	lintIgnoreExitCode = true,
	lintFormats = {
		"%f:%l %m",
		"%f:%l:%c %m",
		"%f: %l: %m",
	},
})

local pylint = c.linter({
	lintSource = "pylint",
	lintCommand = "pylint --score no --output-format text --msg-template {path}:{line}:{column}:{C}:{msg} --from-stdin ${ROOT}",
	lintStdin = true,
	lintIgnoreExitCode = true,
	lintOffsetColumns = 1,
	lintFormats = {
		"%f:%l:%c:%t:%m",
	},
	lintCategoryMap = {
		I = "H",
		R = "I",
		C = "I",
		W = "W",
		E = "E",
		F = "E",
	},
})

c.add(c.filetypes("c", "cpp"), clangd, c.auto_format)
c.add(c.filetypes("css", "html", "json", "yaml"), efm, prettierd, c.auto_format)
c.add(c.filetypes("dockerfile"), docker_ls, c.auto_format)
c.add(c.filetypes("dockerfile"), efm, hadolint)
c.add(c.filetypes("go"), gopls, gopls_organise_imports, c.auto_format, c.snippet)
c.add(c.filetypes("lua"), efm, stylua, c.auto_format)
c.add(c.filetypes("sql", "pgsql"), efm, pg_format, c.auto_format)
c.add(c.filetypes("python"), efm, black, pylint, c.auto_format)
c.add(c.filetypes("python"), pyright)
c.add(c.filetypes("sh"), efm, shfmt, shellcheck, c.auto_format)
c.add(c.filetypes("sh"), bash_ls)
c.add(c.filetypes("svelte"), efm, prettierd, c.auto_format)
c.add(c.filetypes("typescript", "typescriptreact", "javascript"), efm, prettierd, eslint_d, c.auto_format)
c.add(c.filetypes("typescript", "typescriptreact", "javascript"), ts_server)
c.add(c.filetypes("vue"), efm, prettierd, c.auto_format)
c.add(c.filetypes("vue", "html"), tailwind_intellisense)
c.add(c.filetypes("markdown"), efm, markdownlint, pandoc_markdown, c.auto_format)

compe.setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "disable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,
	source = {
		path = true,
		buffer = true,
		nvim_lsp = true,
		vsnip = true,
	},
})
