-- bash        npm install -g bash-language-server
-- c           <package manager> install clang
-- dockerfile  npm install -g dockerfile-language-server-nodejs
-- go          go get -u golang.org/x/tools/gopls@latest
-- python      npm install -g pyright
-- js, ts      npm install -g typescript typescript-language-server
-- svelte      npm install -g svelte svelte-language-server
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                 {virtual_text = false, signs = true, update_in_insert = false})

local lsp = require 'lspconfig'
local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'
local illuminate = require 'illuminate'

local function add(name, config)
    local args = {
        on_attach = function(client)
            illuminate.on_attach(client)
        end
    }
    configs[name] = {default_config = config}
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
})

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
})

add('custom_svelte', {
    cmd = {'svelteserver', '--stdio'},
    filetypes = {'svelte'},
    root_dir = util.root_pattern('package.json', '.git')
})
