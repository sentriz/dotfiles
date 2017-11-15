# Defined in /tmp/fish.rpsWbS/fish_prompt.fish @ line 2
function fish_prompt
    set -l items (date +%A | tr '[:upper:]' '[:lower:]') \
                 (set_color "$host_colour")(hostname)(set_color normal) \
                 (set -q VIRTUAL_ENV; and basename "$VIRTUAL_ENV env") \
                 (prompt_pwd) \
                 ''
    string join ', ' $items
end
