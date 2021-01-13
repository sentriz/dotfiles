# Defined in /tmp/fish.yVO8Iu/fish_prompt.fish @ line 2
function fish_prompt
    set_color "$fish_color_host"
    echo -n "$HOSTNAME"

    set_color --dim white
    echo -n " "(prompt_pwd)

    echo -n " "
    set_color normal
end
