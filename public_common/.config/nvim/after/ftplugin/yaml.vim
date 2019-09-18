setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2

augroup AutoYAMLCursorColumn
    autocmd!
    autocmd InsertLeave * setlocal cursorcolumn
    autocmd InsertEnter * setlocal nocursorcolumn
augroup END
