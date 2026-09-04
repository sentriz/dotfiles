function fish_right_prompt
    set -l branch (git symbolic-ref --quiet --short HEAD 2>/dev/null)
    test -z "$branch"; and return

    set -l count (git diff-index HEAD -- 2>/dev/null | wc -l)
    test $count -eq 1; and echo -n "$count change "
    test $count -gt 1; and echo -n "$count changes "

    test "$branch" = master
    and set_color brred
    or set_color brgreen
    echo -n "$branch"

    set_color normal
end
