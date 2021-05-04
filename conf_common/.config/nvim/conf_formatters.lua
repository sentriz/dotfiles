-- prettierd            npm install -g https://github.com/fsouza/prettierd
-- prettier go template npm install -g prettier prettier-plugin-go-template
-- prettier svelte      npm install -g prettier prettier-plugin-svelte svelte
-- goimports            go get -u golang.org/x/tools/cmd/goimports
-- clang-format         <package manager> install clang
-- black                pip install --user black
-- lua-format           <package manager> install lua-format
-- pg_format            https://github.com/darold/pgFormatter
local formatter = require 'formatter'

local function formatter_prettier()
    return {
        exe = 'prettierd',
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

local function formatter_goimports()
    return {exe = 'gofmt', stdin = true}
end

local function formatter_clang()
    return {
        exe = 'clang-format',
        args = {'--assume-filename', vim.api.nvim_buf_get_name(0), '-'},
        stdin = true
    }
end

local function formatter_black()
    return {exe = 'black', args = {'--quiet', '-'}, stdin = true}
end

local function formatter_shfmt()
    return {exe = 'shfmt', args = {'-i', 4, '-bn', '-'}, stdin = true}
end

local function formatter_luafmt()
    return {
        exe = 'lua-format',
        args = {
            '--double-quote-to-single-quote',
            '--no-keep-simple-function-one-line'
        },
        stdin = true
    }
end

local function formatter_sql()
    return {
        exe = 'pg_format',
        args = {'--keyword-case', 1, '--type-case', 1},
        stdin = true
    }
end

formatter.setup({
    logging = false,
    filetype = {
        ['javascript'] = {formatter_prettier},
        ['typescript'] = {formatter_prettier},
        ['typescriptreact'] = {formatter_prettier},
        ['vue'] = {formatter_prettier},
        ['yaml'] = {formatter_prettier},
        ['yaml.docker-compose'] = {formatter_prettier},
        ['html'] = {formatter_prettier},
        ['css'] = {formatter_prettier},
        ['json'] = {formatter_prettier},
        ['template'] = {formatter_prettier},
        ['svelte'] = {formatter_prettier},
        ['go'] = {formatter_goimports},
        ['c'] = {formatter_clang},
        ['cpp'] = {formatter_clang},
        ['python'] = {formatter_black},
        ['sh'] = {formatter_shfmt},
        ['lua'] = {formatter_luafmt},
        ['sql'] = {formatter_sql},
        ['pgsql'] = {formatter_sql}
    }
})
