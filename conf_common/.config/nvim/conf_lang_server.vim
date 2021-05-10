function OrganiseAndFormat()
     :AutoOrganiseImports
     :FormatWrite
endfunction

augroup AutoLSPSaved
    autocmd!
    autocmd BufWritePre * silent! call OrganiseAndFormat()
augroup END

augroup AutoLSPComplete
    autocmd!
    autocmd CompleteDone * silent! ImportCompleted
augroup END

" highlight symbol under cursor
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

" completion
set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noselect
set shortmess=filnxtToOFAc

" mappings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga    :<c-u>lua vim.lsp.buf.range_code_action()<cr>
nnoremap <silent> J     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <silent> H     <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> L     <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
inoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<cr>

" auto show lsp signature help
autocmd InsertCharPre *
    \ if !pumvisible() && v:char =~# '[A-Za-z\.\_]' |
    \     silent! call feedkeys("\<C-x>\<C-o>", 'n') |
    \ endif

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
