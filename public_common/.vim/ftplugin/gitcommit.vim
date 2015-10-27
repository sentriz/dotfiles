if exists("b:did_ftplugin")
  finish
endif

" don't load twice in one buffer
let b:did_ftplugin = 1

setlocal spell
