function fish_right_prompt
    set -l branch (git symbolic-ref --quiet --short HEAD 2> /dev/null)
    test -z "$branch"; and return
    test "$branch" = master
        and set_color brred
        or set_color brgreen
    echo "$branch"
    set_color normal
    git diff-index --quiet HEAD --
        and echo " clean"
        or echo " dirty"
end
