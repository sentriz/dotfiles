function! Preserve(command)
  let search = @/
  let cursor = getpos(".")
  execute a:command
  let @/ = search
  call setpos(".", cursor)
endfunction
