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
local illuminate = require 'illuminate'

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false, signs = true, update_in_insert = false})

function organise_imports_go()
    local context = {source = {organizeImports = true}}
    vim.validate {context = {context, 't', true}}
    local params = vim.lsp.util.make_range_params()
    params.context = context
    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction',
                                            params, 3000)
    if not result or next(result) == nil then return end
    local actions = result[1].result
    if not actions then return end
    local action = actions[1]
    if action.edit or type(action.command) == 'table' then
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit)
        end
        if type(action.command) == 'table' then
            vim.lsp.buf.execute_command(action.command)
        end
    else
        vim.lsp.buf.execute_command(action)
    end
end

function organise_imports_ts()
    vim.lsp.buf.execute_command({
        command = '_typescript.organizeImports',
        arguments = {vim.api.nvim_buf_get_name(0)}
    })
end

function import_completed()
    local completed_item = vim.v.completed_item
    if not (completed_item and completed_item.user_data and
        completed_item.user_data.nvim and completed_item.user_data.nvim.lsp and
        completed_item.user_data.nvim.lsp.completion_item) then return end

    local item = completed_item.user_data.nvim.lsp.completion_item
    local bufnr = vim.api.nvim_get_current_buf()
    vim.lsp.buf_request(bufnr, 'completionItem/resolve', item,
                        function(_, _, result)
        if result and result.additionalTextEdits then
            vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
        end
    end)
end

local function add(name, default_config, commands)
    local args = {
        on_attach = function(client)
            illuminate.on_attach(client)
        end
    }
    configs[name] = {default_config = default_config, commands = commands}
    lsp[name].setup(args)
end

add('custom_bash', {
    cmd = {'bash-language-server', 'start'},
    filetypes = {'sh'},
    root_dir = util.path.dirname
})

add('custom_clang', {
    cmd = {
        'clangd', '--background-index', '--pch-storage=memory', '--clang-tidy'
    },
    filetypes = {'c', 'cpp', 'objc', 'objcpp'},
    root_dir = util.root_pattern('compile_commands.json', 'compile_flags.txt',
                                 '.git'),
    capabilities = {textDocument = {completion = {editsNearCursor = true}}}
})

add('custom_docker', {
    cmd = {'docker-langserver', '--stdio'},
    filetypes = {'dockerfile'},
    root_dir = util.root_pattern('Dockerfile')
})

add('custom_go', {
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
        },
        capabilities = {
            textDocument = {
                completion = {completionItem = {snippetSupport = true}}
            }
        }
    }
}, {OrganizeImports = {organise_imports_go}})

add('custom_python', {
    cmd = {'pyright-langserver', '--stdio'},
    filetypes = {'python'},
    root_dir = util.root_pattern('requirements.txt', 'pyproject.toml',
                                 'Pipfile', '.git'),
    settings = {
        python = {
            analysis = {autoSearchPaths = true, useLibraryCodeForTypes = true}
        }
    }
})

add('custom_typescript', {
    cmd = {'typescript-language-server', '--stdio'},
    filetypes = {
        'javascript', 'javascriptreact', 'javascript.jsx', 'typescript',
        'typescriptreact', 'typescript.tsx'
    },
    root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git')
}, {
    OrganizeImports = {organise_imports_ts},
    ImportCompleted = {import_completed}
})

add('custom_svelte', {
    cmd = {'svelteserver', '--stdio'},
    filetypes = {'svelte'},
    root_dir = util.root_pattern('package.json', '.git')
})

add('custom_tailwind', {
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
})
