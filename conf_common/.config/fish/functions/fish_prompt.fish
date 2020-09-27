# Defined in /tmp/fish.yVO8Iu/fish_prompt.fish @ line 2
function fish_prompt
    printf '%s%s %s%s %s' \
        (set_color "$fish_color_host") \
        "$HOSTNAME" \
        (set_color --dim white) \
        (prompt_pwd) \
        (set_color normal)
end
