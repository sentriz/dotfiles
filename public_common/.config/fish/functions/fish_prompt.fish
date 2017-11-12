# Defined in /tmp/fish.CCTv7q/fish_prompt.fish @ line 2
function fish_prompt
	set env_string ''
    if set -q VIRTUAL_ENV
        set env_string ', '(basename "$VIRTUAL_ENV")' env'
    end
    printf (set_color "$host_colour")"%s"(set_color normal)"$env_string, %s, " (hostname) (prompt_pwd)
end
