" don't load twice in one buffer
if exists("b:did_git_ftplugin")
  finish
endif
let b:did_git_ftplugin = 1

setlocal spell
autocmd BufWritePre COMMIT_EDITMSG 1,/^#/s/b/🅱/gi
