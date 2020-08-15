lua <<EOF
local lsp     = require'nvim_lsp'
local configs = require'nvim_lsp/configs'
local util    = require'nvim_lsp/util'

function organise_imports()
    local params = vim.lsp.util.make_range_params()
    params.context = { source = { organizeImports = true } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
    if not result then return end
    result = result[1].result
    if not result then return end
    edit = result[1].edit
    vim.lsp.util.apply_workspace_edit(edit)
end

function format_document()
    return vim.lsp.buf.formatting_sync(nil, 1000)
end

-- -- go -- --
configs.c_lsp_go = {
    default_config = {
        cmd = {'gopls'};
        filetypes = {'go'};
        root_dir = util.root_pattern('go.mod', '.git');
        settings = {};
    };
};

-- -- python -- --
configs.c_lsp_python = {
    default_config = {
        cmd = {'python3', '-m', 'pyls'};
        filetypes = {'python'};
        root_dir = util.root_pattern('requirements.txt', 'pyproject.toml', 'Pipfile', '.git');
        settings = {
            pyls = {
                configurationSources = { 'flake8' };
            }
        };
    };
};

-- -- typescript -- --
configs.c_lsp_typescript = {
    default_config = {
        cmd = {'typescript-language-server', '--stdio'};
        filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx'};
        root_dir = util.root_pattern('package.json', 'tsconfig.json', '.git');
    };
};

-- -- bash -- --
configs.c_lsp_bash = {
    default_config = {
        cmd = {'bash-language-server', 'start'};
        filetypes = {'sh'};
        root_dir = util.path.dirname;
    };
};

-- -- clang -- --
configs.c_lsp_clang = {
    default_config = {
        cmd = {'clangd', '--background-index'};
        filetypes = {'c', 'cpp', 'objc', 'objcpp'};
        root_dir = util.root_pattern('compile_commands.json', 'compile_flags.txt', '.git');
        capabilities = {
            textDocument = {
                completion = {
                    editsNearCursor = true;
                }
            }
        };
    };
}

lsp.c_lsp_go.setup{}
lsp.c_lsp_python.setup{}
lsp.c_lsp_typescript.setup{}
lsp.c_lsp_bash.setup{}
lsp.c_lsp_clang.setup{}

EOF

nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

set completeopt-=preview
set omnifunc=v:lua.vim.lsp.omnifunc

autocmd BufWritePre *.go      lua organise_imports()
autocmd BufWritePre *.go,*.py lua format_document()
