nnoremap <bs><bs>     <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <bs><bs><bs> <cmd>lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<cr>
nnoremap <bs>9        <cmd>lua require'dap'.stop()<cr>
nnoremap <bs>0        <cmd>lua require'dap'.continue()<cr>
nnoremap <bs>=        <cmd>lua require'dap'.step_into()<cr>
nnoremap <bs>==       <cmd>lua require'dap'.step_out()<cr>
nnoremap <bs>-        <cmd>lua require'dap'.step_over()<cr>
nnoremap <bs>[        <cmd>lua require'dap'.up()<cr>
nnoremap <bs>]        <cmd>lua require'dap'.down()<cr>
nnoremap <bs>#        <cmd>lua require'dap'.repl.open()<cr>
nnoremap <bs>1        <cmd>lua require'dap'.run_last()<cr>
