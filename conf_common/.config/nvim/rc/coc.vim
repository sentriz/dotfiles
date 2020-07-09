call coc#config('languageserver', {
\     'go': {
\         'command': 'gopls',
\         'filetypes': ['go'],
\         'rootPatterns': ['go.mod', 'go.sum', '.git'],
\         'trace.server': 'verbose'
\     },
\     'python': {
\         'command': 'python3',
\         'args': ['-m', 'pyls', '-vv'],
\         'filetypes': ['python'],
\         'rootPatterns': ['requirements.txt', 'pyproject.toml', 'Pipfile', '.git'],
\         'settings': {
\             'pyls': {
\                 'enable': 'true',
\                 'trace': { 'server': 'verbose' },
\                 'commandPath': '',
\                 'configurationSources': [ 'flake8' ],
\                 'plugins': {
\                     'jedi_completion': { 'enabled': 'true' },
\                     'jedi_hover':      { 'enabled': 'true' },
\                     'jedi_references': { 'enabled': 'true' },
\                     'pyflakes':        { 'enabled': 'true' },
\                     'rope_completion': { 'enabled': 'true' }
\                 }
\             }
\         },
\         'trace.server': 'verbose'
\     },
\     'typescript': {
\         'command': 'typescript-language-server',
\         'args': ['--stdio'],
\         'filetypes': ['javascript', 'typescript', 'typescriptreact'],
\         'rootPatterns': ['package.json', 'node_modules', 'tsconfig.json'],
\         'trace.server': 'verbose'
\     },
\     'bash': {
\         'command': 'bash-language-server',
\         'args': ['start'],
\         'filetypes': ['sh'],
\         'ignoredRootPaths': ['~']
\     }
\ })

call coc#config('coc', {
\     'preferences': {
\          'formatOnSaveFiletypes': ['go', 'python'],
\     }
\ })

autocmd BufWritePre *.go
    \ call CocAction('runCommand', 'editor.action.organizeImport')

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> <c-]> <Plug>(coc-definition)
nmap <silent> gy    <Plug>(coc-type-definition)
nmap <silent> gi    <Plug>(coc-implementation)
nmap <silent> gr    <Plug>(coc-references)
