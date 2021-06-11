" highlight symbol under cursor
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

" completion
set completeopt=menuone,noselect
set shortmess=filnxtToOFAc

" mappings
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]>       <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD          <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD         <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn          <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0          <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW          <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga          <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga          :<c-u>lua vim.lsp.buf.range_code_action()<cr>
nnoremap <silent> J           <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <silent> H           <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> L           <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
inoremap <silent> <c-s>       <cmd>lua vim.lsp.buf.signature_help()<cr>

inoremap <silent><expr> <c-x><c-o> compe#complete()
inoremap <silent><expr> <cr>       compe#confirm('<cr>')
inoremap <silent><expr> <c-e>      compe#close('<c-e>')

imap <expr> <tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
smap <expr> <tab>   vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<tab>'
imap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'
smap <expr> <s-tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<s-tab>'

augroup AutoFormat
    autocmd!
    autocmd BufWritePre * lua require("nvim-lsp-compose").write()
augroup END

sign define LspDiagnosticsSignError       text=ee texthl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning     text=ww texthl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=ii texthl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint        text=hh texthl=LspDiagnosticsSignHint

highlight link LspDiagnosticsFloatingError LspDiagnosticsFloatingError
highlight link NormalFloat Pmenu

highlight def link LspReference  CursorLine
highlight def link LspReferenceText CursorLine
highlight def link LspReferenceWrite CursorLine
highlight def link LspReferenceRead CursorLine
