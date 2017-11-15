# Defined in /tmp/fish.5XjncK/fish_prompt.fish @ line 2
function fish_prompt
	set env_string ''
    if set -q VIRTUAL_ENV
        set env_string ', '(basename "$VIRTUAL_ENV")' env'
    end
    printf "%s, "(set_color "$host_colour")"%s"(set_color normal)"$env_string, %s, " (date +%A | tr '[:upper:]' '[:lower:]') (hostname) (prompt_pwd)
end
