# Defined in /tmp/fish.VJZqFS/fish_right_prompt.fish @ line 2
function fish_right_prompt --description 'Write out the git right prompt'
	set -l branch (git symbolic-ref --quiet --short HEAD 2> /dev/null)
    if test -z "$branch"
        return
    end
    if test "$branch" = master
        set_color brred
    else
        set_color brgreen
    end
    echo "$branch"
    set_color normal
    if git diff-index --quiet HEAD --
        echo " clean"
    end
end
