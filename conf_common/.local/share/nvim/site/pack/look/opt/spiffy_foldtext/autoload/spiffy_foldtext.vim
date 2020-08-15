" Justification for this file's existence: some people use folds way less
" frequently than I do.

"│-v-1 │ s:parse_data stuff
"└─────┴────────────────────

  "│-v-2 │ Populating s:parse_data
  "└─────┴─────────────────────────

let s:literal_text = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '\([^%]\+\)',
    \ 'callback'      : 's:AppendString(l:match_list[1])',
    \ }

let s:escaped_percent = {
    \ 'capture_count' : 0,
    \ 'pattern'       : '%%',
    \ 'callback'      : 's:AppendString("%")',
    \ }

" Needs l:match_list[1] at the time of parsing, see note for
" s:formatted_line_count & s:fold_level_indent .
let s:filled_text_of_line = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '%c{\([^}]*\)}',
    \ 'callback'      : 's:AppendString([''s:FillWhitespace(l:line1_text, "'' . l:match_list[1] . ''")''])',
    \ }

" Yes, this pattern collides with the previous one. As such, this one must
" come after it.
let s:text_of_line = {
    \ 'capture_count' : 0,
    \ 'pattern'       : '%c',
    \ 'callback'      : 's:AppendString([''l:line1_text''])',
    \ }

" Where the right begins and is able to overlap the left, if the line's too big.
let s:split_mark = {
    \ 'capture_count' : 0,
    \ 'pattern'       : '%<',
    \ 'callback'      : 's:MarkSplit()',
    \ }

" Where the fill string fills, if the line's too short.
let s:fill_mark = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '%f{\([^}]*\)}',
    \ 'callback'      : 's:MarkFill(l:match_list[1])',
    \ }

" Are these next two callbacks confusing enough for you? The idea is they need
" the l:match_list[1] value at the time of parsing. They're appended as lists
" of 1 member so they become compile-time callbacks (i.e., a list of string(s)
" is executed later). So part is a parse-time callback, and part is compile
" time.
"
" It's just hard to format it correctly here.
let s:formatted_line_count = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '%\(\d*\)n',
    \ 'callback'      : 's:AppendString([''printf("%'' . l:match_list[1] . ''s", l:lines_count)''])',
    \ }

" Repeated string representing fold level (repeated v:foldlevel - 1 times)
let s:fold_level_indent = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '%l{\([^}]*\)}',
    \ 'callback'      : 's:AppendString([''repeat("'' . l:match_list[1] .  ''", v:foldlevel - 1)''])',
    \ }

let s:formatted_level_count = {
    \ 'capture_count' : 1,
    \ 'pattern'       : '%\(\d*\)fl',
    \ 'callback'      : 's:AppendString([''printf("%'' . l:match_list[1] . ''s", v:foldlevel)''])',
    \ }


" There is deliberate pattern collision. The order matters.
let s:parse_data = [ s:literal_text, s:escaped_percent, s:filled_text_of_line,
    \ s:text_of_line, s:split_mark, s:fill_mark, s:formatted_line_count,
    \ s:fold_level_indent, s:formatted_level_count]

  "│-v-2 │ s:parse_data callback functions
  "└─────┴─────────────────────────────────

function! s:AppendString(the_string) "-v-
	return a:the_string
endfunction "-^-

function! s:MarkSplit() "-v-
	return {'mark' : 'split'}
endfunction "-^-

function! s:MarkFill(...) "-v-
	return {'mark' : 'fill', 'fill_string' : a:1}
endfunction "-^-

function! s:FillWhitespace(text_to_change, text_to_repeat) "-v-
	let l:text_to_change = a:text_to_change
	
	" Dashes in the indentation
	let l:text_to_change = substitute(
	    \ l:text_to_change,
	    \ '^[ ]\+',
	    \ '\=s:FillSpaceWithString( a:text_to_repeat, strlen(submatch(0)) - 1 ) . " " ',
	    \ 'e')
	
	" fill fairly wide whitespace regions
	let l:text_to_change = substitute(
	    \ l:text_to_change,
	    \ ' \([ ]\{3,}\) ',
	    \ '\=" " . s:FillSpaceWithString( a:text_to_repeat, strlen(submatch(1))) . " " ',
	    \ 'g')
	
	return l:text_to_change
endfunction "-^-

"│-v-1 │ Main functionality
"└─────┴────────────────────

function! spiffy_foldtext#SpiffyFoldText() "-v-
	return s:CompileFormatString(s:ParsedString(s:StringToUse()))
endfunction "-^-
  "│-v-2 │ Used by spiffy_foldtext#SpiffyFoldText()
  "└─────┴──────────────────────────────────────────

function! s:CompileFormatString(parsed_string) "-v-
	
	let l:callbacked_string = s:ExecuteCallbacks(a:parsed_string)
	let l:actual_winwidth = spiffy_foldtext#ActualWinwidth()
	let l:length_so_far = s:LengthOfListsStrings(l:callbacked_string)
	
	if l:length_so_far > l:actual_winwidth
		let l:return_val = s:ConstrainTooLong(l:callbacked_string, l:actual_winwidth)
	else
		let l:return_val = s:StretchTooShort(l:callbacked_string, l:actual_winwidth)
	endif
	
	return return_val
endfunction "-^-
    "│-v-3 │ Used by s:CompileFormatString()
    "└─────┴─────────────────────────────────

function! s:ExecuteCallbacks(parsed_string) "-v-
	let l:callbacked_string = [""]
	
	" Used by the callbacks
	let l:line1_text = spiffy_foldtext#CorrectlySpacify(getline(v:foldstart))
	let l:lines_count = v:foldend - v:foldstart + 1
	
	let l:element = ''
	for i in range(len(a:parsed_string))
		unlet l:element
		let l:element = a:parsed_string[i]
		if type(l:element) == type({})
			let l:callbacked_string += [l:element, ""]
		elseif type(l:element) == type([])
			" This is the notation for a compile-time callback.
			exe 'let l:callbacked_string[-1] .= ' . l:element[0]
		else
			let l:callbacked_string[-1] .= l:element
		endif
	endfor
	
	return l:callbacked_string
endfunction "-^-

function! s:LengthOfListsStrings(...) "-v-
	let l:return_val = 0
	let element = ""
	for i in range(len(a:1))
		unlet element
		let element = a:1[i]
		if type(element) == type("")
			let l:return_val += strdisplaywidth(element)
		endif
	endfor
	return l:return_val
endfunction "-^-

function! s:ConstrainTooLong(callbacked_string, actual_winwidth) "-v-
	" This function is highly specific to the format of the list variable
	" callbacked_string.
	let l:before_split = ""
	let l:after_split = ""
	let l:is_before_split = 1
	let element = ""
	for i in range(len(a:callbacked_string))
		unlet element
		let element = a:callbacked_string[i]
		if type(element) == type("")
			if l:is_before_split
				let l:before_split .= element
			else
				let l:after_split .= element
			endif
		elseif type(element) == type({}) && element.mark == 'split'
			let l:is_before_split = 0
		endif
	endfor
	
	let l:room_for_before = a:actual_winwidth - strdisplaywidth(l:after_split)
	let l:before_split = s:KeepLength(l:before_split, l:room_for_before)
	
	return l:before_split . l:after_split
endfunction "-^-

function! s:StretchTooShort(callbacked_string, actual_winwidth) "-v-
	" This function is highly specific to the format of the list variable
	" callbacked_string.
	let l:before_fill = ""
	let l:after_fill = ""
	let l:fill_string = "-"
	let l:is_before_fill = 1
	for i in range(len(a:callbacked_string))
		unlet element
		let element = a:callbacked_string[i]
		if type(element) == type("")
			if l:is_before_fill
				let l:before_fill .= element
			else
				let l:after_fill .= element
			endif
		elseif type(element) == type({}) && element.mark == 'fill'
			let l:is_before_fill = 0
			let l:fill_string = element.fill_string
		endif
	endfor
	
	let l:room_for_fill = a:actual_winwidth - (strdisplaywidth(l:before_fill) + strdisplaywidth(l:after_fill))
	let l:fill = s:FillSpaceWithString(l:fill_string, l:room_for_fill)
	
	return l:before_fill . l:fill . l:after_fill
endfunction "-^-

    "┌─────┬─────────────────────────────────
    "│-^-3 │ Used by s:CompileFormatString()

function! s:StringToUse() "-v-
	if exists('w:SpiffyFoldtext_format')
		let l:string_to_use = w:SpiffyFoldtext_format
	elseif exists('b:SpiffyFoldtext_format')
		let l:string_to_use = b:SpiffyFoldtext_format
	else
		let l:string_to_use = g:SpiffyFoldtext_format
	endif
	
	return l:string_to_use
endfunction "-^-

  "┌─────┬──────────────────────────────────────────
  "│-^-2 │ Used by spiffy_foldtext#SpiffyFoldText()

"│-v-1 │ Used by multiple Functions
"└─────┴────────────────────────────

function! s:KeepLength(the_string, space_available) "-v-
	" Gradual arrival at the right value, due to multibytes.
	" VimL sucks
	let l:kept_length = len(a:the_string)
	let l:too_long = 1
	while l:too_long && (l:kept_length > 0)
		let l:kept_strdisplaywidth = strdisplaywidth(
		    \ strpart(a:the_string, 0, l:kept_length))
		let l:over_amount = l:kept_strdisplaywidth - a:space_available
		if l:over_amount > 0
			let l:kept_length -= 1
		else
			let l:too_long = 0
		endif
	endwhile
	
	return strpart(a:the_string, 0, l:kept_length)
endfunction "-^-

function! s:FillSpaceWithString(the_string, available_dispwidth) "-v-
	let l:whole_num_repeat = a:available_dispwidth / strdisplaywidth(a:the_string)
	let l:frac_part_repeat = a:available_dispwidth % strdisplaywidth(a:the_string)
	
	let l:return_val = repeat(a:the_string, l:whole_num_repeat)
	let l:return_val .= s:KeepLength(a:the_string, l:frac_part_repeat)
	return l:return_val
endfunction "-^-

let s:parsed_dictionary = {}
function! s:ParsedString(string_to_parse) "-v-
	" memoized
	if !has_key(s:parsed_dictionary, a:string_to_parse)
		let s:parsed_dictionary[a:string_to_parse] = s:ParseFormatString(a:string_to_parse)
	endif
	
	return s:parsed_dictionary[a:string_to_parse]
endfunction "-^-
  "│-v-2 │ Used by s:ParsedString()
  "└─────┴──────────────────────────

function! s:ParseFormatString(string_to_parse) "-v-
	let l:parsed_string = [""]
	let l:still_to_parse = a:string_to_parse
	while len(l:still_to_parse) != 0
		let l:nomatch = 1
		for l:parse_datum in s:parse_data
			let l:full_pattern = '^' . l:parse_datum.pattern . '\(.*\)$'
			let l:match_list = matchlist(l:still_to_parse, l:full_pattern)
			
			if len(l:match_list) != 0
				let l:nomatch = 0
				
				unlet l:callback_return " Type can’t change without this.
				exe 'let l:callback_return = ' . l:parse_datum.callback
				
				if type(l:callback_return) == type("") && type(l:parsed_string[-1]) == type("")
					let l:parsed_string[-1] .= l:callback_return
				else
					let l:parsed_string += [l:callback_return]
				endif
				
				let l:still_to_parse = l:match_list[l:parse_datum.capture_count + 1]
				break
			endif
		endfor
		if l:nomatch
			" This will only happen with a badly formed format string (or one
			" that uses patterns not available in their installed version).
			" The user really ought to fix their string, but this at least
			" keeps the loop from being infinite when they've made a mistake.
			"
			" The effect *should* be the ignoring of non-escaped %'s that
			" aren't part of a defined pattern.
			let l:still_to_parse = strpart(l:still_to_parse, 1)
		endif
	endwhile
	
	return l:parsed_string
endfunction "-^-

  "┌─────┬──────────────────────────
  "│-^-2 │ Used by s:ParsedString()

"│-v-1 │ Generally useful functions
"└─────┴────────────────────────────

function! spiffy_foldtext#CorrectlySpacify(...) "-v-
	" For converting tabs into spaces in such a way that the line is displayed
	" exactly as it would with tabs.
	
	let l:running_result = a:1
	let l:done = 0
	while !l:done
		" Replace first tab & everything after with nothing.
		let l:up_to_tab = substitute(l:running_result, '\t.*$', '', 'e')
		
		if l:running_result =~# '\t'
			let l:first_tab_col = strdisplaywidth(l:up_to_tab)
			let l:first_tab_dw = strdisplaywidth("\t", l:first_tab_col)
			
			let l:running_result = substitute(
			      \ l:running_result,
			      \ '\t',
			      \ repeat(' ', l:first_tab_dw),
			      \ 'e' )
		else
			let l:done = 1
		endif
	endwhile
	
	return l:running_result
endfunction "-^-

function! spiffy_foldtext#ActualWinwidth() "-v-
	" Finds the display width of that section of the window that actually shows
	" content.
	
	return winwidth(0) - s:NumberColumnWidth() - &foldcolumn - s:SignsWidth()
endfunction "-^-
  "│-v-2 │ Used by spiffy_foldtext#ActualWinwidth()
  "└─────┴──────────────────────────────────────────

function! s:NumberColumnWidth() "-v-
	let l:number_col_width = 0
	
	" Find the width of the number column (0 if none)
	if &number
		" This assumes the number of lines is less than 10,000,000,000
		let l:number_col_width = max([strlen(line('$')) + 1, 3])
	elseif &relativenumber
		" I don’t know how tall a window has to be for this number to be bigger,
		" but I haven’t run into it.
		let l:number_col_width = 3
	endif
	
	if l:number_col_width != 0
		" It's always at least &numberwidth (if showing).
		let l:number_col_width = max([l:number_col_width, &numberwidth])
	endif
	
	return l:number_col_width
endfunction "-^-

function! s:SignsWidth() "-v-
	let l:signs_width = 0
	if has('signs')
		" This seems to be the only way to find out if the signs column is even
		" showing.
		let l:signs = []
		let l:signs_string = ''
		redir =>l:signs_string|exe "sil sign place buffer=".bufnr('')|redir end
		let l:signs = split(l:signs_string, "\n")[1:]
		
		if !empty(signs)
			let l:signs_width = 2
		endif
	endif
	
	return l:signs_width
endfunction "-^-

  "┌─────┬──────────────────────────────────────────
  "│-^-2 │ Used by spiffy_foldtext#ActualWinwidth()


" -v-1 modeline
" vim: set fmr=-v-,-^- fdm=marker list noet ts=4 sw=4 sts=4 :

