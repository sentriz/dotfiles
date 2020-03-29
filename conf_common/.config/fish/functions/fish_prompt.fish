function fish_prompt
    set items \
        (printf '%s%s%s' (set_color "$fish_color_host") "$HOSTNAME" (set_color normal)) \
        (set -q VIRTUAL_ENV; and printf "%s env" (basename "$VIRTUAL_ENV")) \
        (prompt_pwd)
    printf '%s, ' (string join ', ' $items)
end
