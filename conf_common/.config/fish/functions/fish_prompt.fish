# Defined in /tmp/fish.yVO8Iu/fish_prompt.fish @ line 2
function fish_prompt
    set prev_status "$status" # needs to be first

    set jc (jobs | wc -l)
    test "$jc" -gt 0
    and echo -n "$jc "

    set sh_lvl (math "$SHLVL" - 1)
    test "$sh_lvl" -gt 0
    and echo -n (string repeat -N -n $sh_lvl ">")" "

    test "$prev_status" -gt 0
    and set_color brred
    and echo -n "██ "

    set_color "$fish_colour_host"
    echo -n "$HOSTNAME"

    set_color --dim white
    echo -n " "(prompt_pwd)

    echo -n " "
    set_color normal
end
