function clone
    not test -d "$DOTS_PROJECTS_DIR"
    and return 1

    set -l url $argv[1]
    test -z $url
    and return 1

    set -l name (echo $url | grep -Po '\/\K([^\/]+?)(?=(\.git)?$)')
    set -l dest $DOTS_PROJECTS_DIR/$name

    git clone $url $dest
    cd $dest
end
