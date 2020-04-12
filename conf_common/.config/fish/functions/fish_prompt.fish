function fish_prompt
    printf '%s%s%s %s ' \
        (set_color "$fish_color_host") \
        "$HOSTNAME" \
        (set_color normal) \
        (prompt_pwd)
end
