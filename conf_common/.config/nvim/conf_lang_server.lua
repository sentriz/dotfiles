-- bash        npm install -g bash-language-server
-- c           <package manager> install clang
-- dockerfile  npm install -g dockerfile-language-server-nodejs
-- go          go get -u golang.org/x/tools/gopls@latest
-- python      npm install -g pyright
-- js, ts      npm install -g typescript typescript-language-server
-- svelte      npm install -g svelte svelte-language-server
local lsp = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false, signs = true, update_in_insert = false})

vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, {border = 'single'})

vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'single'})

local servers = {}

servers.bash = {}
servers.bash.config = {
    cmd = {'bash-language-server', 'start'},
    filetypes = {'sh'},
    root_dir = util.path.dirname
}

servers.clang = {}
servers.clang.config = {
    cmd = {
        'clangd', '--background-index', '--pch-storage=memory', '--clang-tidy'
    },
    filetypes = {'c', 'cpp', 'objc', 'objcpp'},
    root_dir = util.root_pattern('compile_commands.json', 'compile_flags.txt',
                                 '.git'),
    capabilities = {textDocument = {completion = {editsNearCursor = true}}}
}

servers.docker = {}
servers.docker.config = {
    cmd = {'docker-langserver', '--stdio'},
    filetypes = {'dockerfile'},
    root_dir = util.root_pattern('Dockerfile')
}

servers.go = {}
servers.go.config = {
    cmd = {'gopls'},
    filetypes = {'go'},
    root_dir = util.root_pattern('go.mod', '.git'),
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

servers.go.commands = {}
servers.go.commands.AutoOrganiseImports =
    function()
        local context = {source = {organizeImports = true}}
        vim.validate {context = {context, 't', true}}

        local params = vim.lsp.util.make_range_params()
        params.context = context

        local method = 'textDocument/codeAction'
        local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
        if not resp or not resp[1] then return end
        local result = resp[1].result
        if not result or not result[1] then return end

        local edit = result[1].edit
        vim.lsp.util.apply_workspace_edit(edit)
        vim.lsp.buf.formatting()
    end

servers.python = {}
servers.python.config = {
    cmd = {'pyright-langserver', '--stdio'},
    filetypes = {'python'},
    root_dir = util.root_pattern('requirements.txt', 'pyproject.toml',
                                 'Pipfile', '.git'),
    settings = {
        python = {
            analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true}
        }
    }
}

servers.python.commands = {}
servers.python.commands.AutoOrganiseImports =
    function()
        vim.lsp.buf.execute_command({
            command = 'pyright.organizeimports',
            arguments = {vim.uri_from_bufnr(0)}
        })
    end

servers.typescript = {}
servers.typescript.config = {
    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript',
        'typescriptreact', 'typescript.tsx'
    },
    root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git')
}

servers.typescript.commands = {}
servers.typescript.commands.ImportCompleted =
    function()
        local completed_item = vim.v.completed_item
        if not (completed_item and completed_item.user_data and
            completed_item.user_data.nvim and completed_item.user_data.nvim.lsp and
            completed_item.user_data.nvim.lsp.completion_item) then
            return
        end

        local item = completed_item.user_data.nvim.lsp.completion_item
        local bufnr = vim.api.nvim_get_current_buf()
        vim.lsp.buf_request(bufnr, 'completionItem/resolve', item,
                            function(_, _, result)
            if result and result.additionalTextEdits then
                vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
            end
        end)
    end

servers.typescript.commands = {}
servers.typescript.commands.OrganiseImports =
    function()
        vim.lsp.buf.execute_command({
            command = '_typescript.organizeImports',
            arguments = {vim.api.nvim_buf_get_name(0)}
        })
    end

servers.svelte = {}
servers.svelte.config = {
    cmd = {'svelteserver', '--stdio'},
    filetypes = {'svelte'},
    root_dir = util.root_pattern('package.json', '.git')
}

servers.tailwind = {}
servers.tailwind.config = {
    cmd = {
        'node',
        vim.env.DOTS_PROJECTS_DIR ..
            '/tailwind-lsp/extension/dist/server/index.js', '--stdio'
    },
    filetypes = {'html', 'vue', 'css'},
    root_dir = util.root_pattern('package.json', '.git'),
    handlers = {
        ['tailwindcss/getConfiguration'] = function(_, _, params, _, bufnr, _)
            vim.lsp.buf_notify(bufnr, 'tailwindcss/getConfigurationResponse',
                               {_id = params._id})
        end
    }
}

for server_name, server in pairs(servers) do
    local commands = {}
    for command_name, command in pairs((server.commands or {})) do
        commands[command_name] = {command}
    end
    configs[server_name] = {default_config = server.config, commands = commands}
    lsp[server_name].setup({})
end
