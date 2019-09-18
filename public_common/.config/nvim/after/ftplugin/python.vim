setlocal smarttab
setlocal autoindent
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

augroup AutoPythonBlack
    autocmd!
    autocmd BufWritePre *.py
        \ execute ':Black'
augroup END

