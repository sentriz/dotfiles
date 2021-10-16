# Defined in /tmp/fish.yVO8Iu/fish_prompt.fish @ line 2
function fish_prompt
    test "$status" -gt 0
    and set_color brred
    and echo -n "██ "

    set_color "$fish_colour_host"
    echo -n "$HOSTNAME"

    set_color --dim white
    echo -n " "(prompt_pwd)

    echo -n " "
    set_color normal
end
