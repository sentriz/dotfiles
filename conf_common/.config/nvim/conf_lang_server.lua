-- requires https://github.com/sentriz/nvim-lsp-compose

-- lang servers:
--     bash       npm install -ctx bash-language-server
--     c          <package manager> install clang
--     dockerfile npm install -ctx dockerfile-language-server-nodejs
--     go         go get -u golang.org/x/tools/gopls@latest
--     python     npm install -ctx pyright
--     js, ts     npm install -ctx typescript typescript-language-server
--     svelte     npm install -ctx svelte svelte-language-server

-- formatters:
--     prettierd            npm install -g https://github.com/fsouza/prettierd
--     prettier go template npm install -g prettier prettier-plugin-go-template
--     prettier svelte      npm install -g prettier prettier-plugin-svelte svelte
--     goimports            go get -u golang.org/x/tools/cmd/goimports
--     clang-format         <package manager> install clang
--     black                pip install --user black
--     luafmt               npm install -g lua-fmt
--     pg_format            https://github.com/darold/pgFormatter

-- linters:
--     shellcheck <package manager> install shellcheck
--     eslint_d   npm install -g eslint_d

local lsp = require "lspconfig"
local configs = require "lspconfig/configs"
local util = require "lspconfig/util"

local compose = require "nvim-lsp-compose"
local server = compose.server
local action = compose.action
local linter = compose.linter
local formatter = compose.formatter
local auto_format = compose.auto_format

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {virtual_text = false, signs = true, update_in_insert = false}
)

local function bash_ls()
    return {
        cmd = {"bash-language-server", "start"},
        root_dir = util.path.dirname
    }
end

local function gopls()
    return {
        cmd = {"gopls"},
        root_dir = util.root_pattern("go.mod", ".git"),
        settings = {
            gopls = {
                usePlaceholders = true,
                completeUnimported = true,
                deepCompletion = true,
                staticcheck = true,
                analyses = {unreachable = true, unusedparams = true}
            }
        }
    }
end

local function gopls_organise_imports(client, buff_num)
    local context = {source = {organizeImports = true}}
    vim.validate {context = {context, "t", true}}

    local params = vim.lsp.util.make_range_params()
    params.context = context

    local resp = client.request_sync("textDocument/codeAction", params, 500, buff_num)
    if not resp then
        return
    end

    for _, v in next, resp, nil do
        if v[1].edit then
            vim.lsp.util.apply_workspace_edit(v[1].edit)
        end
    end
end

local function efm()
    return {
        cmd = {"efm-langserver"},
        init_options = {v = 1},
        settings = {rootMarkars = {".git"}, languages = {}},
        root_dir = function(filename)
            return util.root_pattern(".git")(filename) or util.path.dirname(filename)
        end
    }
end

local function clangd()
    return {
        cmd = {
            "clangd",
            "--background-index",
            "--pch-storage=memory",
            "--clang-tidy"
        },
        root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        capabilities = {textDocument = {completion = {editsNearCursor = true}}}
    }
end

local function docker_ls()
    return {
        cmd = {"docker-langserver", "--stdio"},
        root_dir = util.root_pattern("Dockerfile")
    }
end

local function pyright()
    return {
        cmd = {"pyright-langserver", "--stdio"},
        root_dir = util.root_pattern("requirements.txt", "pyproject.toml", "Pipfile", ".git"),
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true
                }
            }
        }
    }
end

local function pyright_organise_imports(client, buff_num)
    local params = {
        command = "pyright.organizeimports",
        arguments = {vim.uri_from_bufnr(buff_num)}
    }
    client.request_sync("workspace/executeCommand", params, 2000)
end

local function ts_server()
    return {
        cmd = {"typescript-language-server", "--stdio"},
        root_dir = util.root_pattern("package.json", "tsconfig.json", ".git")
    }
end

local function ts_server_organise_imports(client, buff_num)
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)}
    }
    client.request("workspace/executeCommand", params, 1000, buff_num)
end

local prettier = formatter("prettier", "--stdin-filepath", "${INPUT}")
local prettierd = formatter("prettierd", "${INPUT}")
local gofmt = formatter("gofmt")
local goimports = formatter("goimports")
local clang_format = formatter("clang-format", "--assume-filename", "${INPUT}", "-")
local black = formatter("black", "--quiet", "-")
local shfmt = formatter("shfmt", "-i", 4, "-bn", "-")
local luafmt = formatter("luafmt", "--stdin")
local pg_format = formatter("pg_format", "--keyword-case", 1, "--type-case", 1)

local shellcheck =
    linter(
    {
        lintSource = "shellcheck",
        lintCommand = "shellcheck --format gcc -",
        lintStdin = true,
        lintFormats = {
            "%f:%l:%c: %trror: %m",
            "%f:%l:%c: %tarning: %m",
            "%f:%l:%c: %tote: %m"
        }
    }
)

local eslint_d =
    linter(
    {
        lintSource = "eslint",
        lintCommand = "eslint_d --format visualstudio --stdin --stdin-filename ${INPUT}",
        lintStdin = true,
        lintIgnoreExitCode = true,
        lintFormats = {
            "%f(%l,%c): %tarning %m",
            "%f(%l,%c): %rror %m"
        }
    }
)

compose.setup(
    {
        {
            filetypes = {"c", "cpp"},
            servers = {
                {server(clangd), auto_format}
            }
        },
        {
            filetypes = {"css", "html", "json", "yaml"},
            servers = {
                {server(efm), prettierd, auto_format}
            }
        },
        {
            filetypes = {"dockerfile"},
            servers = {
                {server(docker_ls), auto_format}
            }
        },
        {
            filetypes = {"go"},
            servers = {
                {server(gopls), action(gopls_organise_imports), auto_format}
            }
        },
        {
            filetypes = {"lua"},
            servers = {
                {server(efm), luafmt, auto_format}
            }
        },
        {
            filetypes = {"sql", "pgsql"},
            servers = {
                {server(efm), pg_format, auto_format}
            }
        },
        {
            filetypes = {"python"},
            servers = {
                {server(pyright), action(pyright_organise_imports)},
                {server(efm), black, auto_format}
            }
        },
        {
            filetypes = {"sh"},
            servers = {
                {server(efm), shfmt, shellcheck, auto_format},
                {server(bash_ls)}
            }
        },
        {
            filetypes = {"svelte"},
            servers = {
                {server(efm), prettierd, auto_format}
            }
        },
        {
            filetypes = {"typescript", "typescriptreact", "javascript"},
            servers = {
                {server(efm), prettierd, eslint_d, auto_format},
                {server(ts_server)}
            }
        },
        {
            filetypes = {"vue"},
            servers = {
                {server(efm), prettierd, auto_format}
            }
        }
    }
)
