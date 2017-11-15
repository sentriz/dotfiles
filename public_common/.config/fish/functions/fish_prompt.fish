# Defined in /tmp/fish.b3iMas/fish_prompt.fish @ line 2
function fish_prompt
	if test "$status" -eq 0; set prefix_colour normal
    else;                    set prefix_colour red
    end
	set items  (set_color "$host_colour")(hostname)(set_color normal) \
               (set -q VIRTUAL_ENV; and basename "$VIRTUAL_ENV env") \
               (prompt_pwd)
    set prefix (set_color "$prefix_colour")'■'(set_color normal)
    printf '%s %s, ' $prefix (string join ', ' $items)
end
