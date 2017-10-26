# Defined in /tmp/fish.nsftX2/cast_seed_fuzz.fish @ line 2
function cast_seed_fuzz
	set -l dir       $HOME/mounts/seed/downloads/senan
    set -l selection (ls "$dir" | fzf)
    castnow "$dir"/"$selection"/*
end
