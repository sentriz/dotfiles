" highlight symbol under cursor
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

" completion
set completeopt=menu,menuone,noselect
set shortmess=filnxtToOFAc

" mappings
nnoremap <silent> gd      <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> K       <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <c-]>   <cmd>lua require('goto-preview').goto_preview_definition()<cr>
nnoremap <silent> gD      <cmd>lua require('goto-preview').goto_preview_implementation()<cr>
nnoremap <silent> 1gD     <cmd>lua require('goto-preview').goto_preview_type_definition()<cr>
nnoremap <silent> <enter> <cmd>vsplit \| lua require('goto-preview').close_all_win()<cr>
nnoremap <silent> gr      <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn      <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0      <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW      <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga      <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga      :<c-u>lua vim.lsp.buf.range_code_action()<cr>
vnoremap <silent> gt      <cmd>lua vim.diagnostic.setqflist()<cr>
inoremap <silent> <c-s>   <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> J       <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <silent> H       <cmd>lua vim.diagnostic.goto_prev()<cr>
nnoremap <silent> L       <cmd>lua vim.diagnostic.goto_next()<cr>
