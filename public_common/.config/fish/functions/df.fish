# Defined in /tmp/fish.D4S5OO/df.fish @ line 2
function df
    command df -h $argv | grep --color -E '^|.*md126.*|.*/$|.*home.*'
end
