# Defined in /tmp/fish.PO8LDh/fish_prompt.fish @ line 2
function fish_prompt
	if test "$status" -eq 0; set prefix_colour normal
    else;                    set prefix_colour red
    end
	set items (set_color "$prefix_colour")'■'(set_color normal) \
	          (set_color "$host_colour")(hostname)(set_color normal) \
              (set -q VIRTUAL_ENV; and printf "%s env" (basename "$VIRTUAL_ENV")) \
              (prompt_pwd)
    printf '%s, ' (string join ', ' $items)
end
