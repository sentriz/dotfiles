
if !exists("g:SpiffyFoldtext_use_multibyte")
	let g:SpiffyFoldtext_use_multibyte = 1
endif

let s:use_multibyte = g:SpiffyFoldtext_use_multibyte && has('multi_byte')

if !exists("g:SpiffyFoldtext_format")
	if s:use_multibyte
		let g:SpiffyFoldtext_format = "%c{═}  %<%f{═}╡ %4n lines ╞═%l{╤═}"
	else
		let g:SpiffyFoldtext_format = "%c{=}  %<%f{=}| %4n lines |=%l{/=}"
	endif
endif

" vim: set fmr=-v-,-^- fdm=marker list noet ts=4 sw=4 sts=4 :

