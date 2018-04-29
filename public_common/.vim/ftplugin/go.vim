" don't load twice in one buffer
if exists("b:did_go_ftplugin")
  finish
endif
let b:did_go_ftplugin = 1

nnoremap <leader>r :!clear<CR>:GoRun<CR>
