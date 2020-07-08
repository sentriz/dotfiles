setlocal autoindent
setlocal noexpandtab
setlocal smarttab
setlocal shiftwidth=4
setlocal tabstop=4

autocmd BufWritePre <buffer>
    \ call CocAction('runCommand', 'editor.action.organizeImport')
