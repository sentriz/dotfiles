function clone
    not test -d "$PROJECTS_DIR"
    and return 1

    set -l url $argv[1]
    test -z $url
    and return 1

    set -l dest $argv[2]
    if test -z $dest
        set -l name (echo $url | grep -Po '\/\K([^\/]+?)(?=(\.git)?$)')
        set dest $PROJECTS_DIR/$name
    end

    if test -d "$dest"
        cd $dest
        return
    end

    git clone $url $dest
    cd $dest
end
