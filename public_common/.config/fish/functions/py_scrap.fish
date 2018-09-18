# Defined in /tmp/fish.J7c8Eo/go-scrap.fish @ line 2
function py_scrap
    set -l scrap_dir ~/scrap
    switch $argv[1]
    case n new
        if test (count $argv) -eq 2
           vim (mktemp -d $scrap_dir/python.$argv[2].XXX)/main.py
        else
           vim (mktemp -d $scrap_dir/python.XXX)/main.py
        end
    case l last
        vim $scrap_dir/(ls -Art $scrap_dir | tail -n 1)/main.py
    end
end
