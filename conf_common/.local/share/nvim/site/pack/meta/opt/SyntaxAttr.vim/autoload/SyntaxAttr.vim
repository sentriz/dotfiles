" EXAMPLE SETUP
"
" Show the syntax group name of the item under cursor.
"	map -a	:call SyntaxAttr#SyntaxAttr()<CR>

function! SyntaxAttr#GetSyntax()
     let id1  = synID(line("."), col("."), 1)
     if id1 == 0
	  " Fall back to naming the transparent group when there's no underlying
	  " syntax group that colors the position.
	  let id1  = synID(line("."), col("."), 0)
     endif

     return [id1, synIDattr(id1, "name")]
endfunction
function! SyntaxAttr#Get( mode )
     let synid = ""
     let fg = ""
     let bg = ""
     let attr   = ""

     let [id1, name1] = SyntaxAttr#GetSyntax()
     let tid1 = synIDtrans(id1)

     if ! empty(name1)
	  let synid = name1
	  if (tid1 != id1)
	       let synid = synid . '->' . synIDattr(tid1, "name", a:mode)
	  endif
	  let id0 = synID(line("."), col("."), 0)
	  if (synIDattr(id1, "name", a:mode) != synIDattr(id0, "name", a:mode))
	       let synid = synid .  " (" . synIDattr(id0, "name", a:mode)
	       let tid0 = synIDtrans(id0)
	       if (tid0 != id0)
		    let synid = synid . '->' . synIDattr(tid0, "name", a:mode)
	       endif
	       let synid = synid . ")"
	  endif
     endif

     " Use the translated id for all the color & attribute lookups; the linked id yields blank values.
     let fg = s:GetColorFormat(a:mode, 'fg', s:Color(synIDattr(tid1, "fg", a:mode), synIDattr(tid1, "fg#", a:mode)))
     let bg = s:GetColorFormat(a:mode, 'bg', s:Color(synIDattr(tid1, "bg", a:mode), synIDattr(tid1, "bg#", a:mode)))

     for attrName in ['bold', 'italic', 'reverse', 'standout', 'underline', 'undercurl', 'strikethrough', 'nocombine']
	  if (synIDattr(tid1, attrName, a:mode))
	       let attr   = attr . ',' . attrName
	  endif
     endfor
     if ! empty(synIDattr(tid1, "font", a:mode))
	  let attr   = attr . " font=" . synIDattr(tid1, "font", a:mode)
     endif
     if (attr != ""                  )
	  let attr   = substitute(attr, "^,", " attr=", "")
     endif

     return [synid, fg . bg . attr]
endfunction
function! s:Color( colorName, colorRgb )
     return (a:colorName ==? a:colorRgb ? a:colorRgb : printf('%s(%s)', a:colorName, a:colorRgb))
endfunction
function! s:GetColorFormat( mode, attr, color )
     return (empty(a:color) || a:color == -1 ? '' : printf(' %s%s=%s', a:mode, a:attr, a:color))
endfunction
function! SyntaxAttr#SyntaxAttr()
     let l:mode = (has('gui_running') ? 'gui' : (&t_Co > 2 ? 'cterm' : 'term'))
     echohl MoreMsg
     let message = "group: " . join(SyntaxAttr#Get(l:mode), '')
     if message == ""
	  echohl WarningMsg
	  let message = "<no syntax group here>"
     endif
     echo message
     echohl None
endfunction
