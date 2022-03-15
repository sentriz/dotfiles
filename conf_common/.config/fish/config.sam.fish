set -xg fish_colour_host blue

function p --argument project
    cd "$DOTS_PROJECTS_DIR/$project"
end

complete -x --command p --arguments ( \
    find "$DOTS_PROJECTS_DIR" \
        -maxdepth 1 -mindepth 1 \
        -type d \
        -printf '%P ' \
)

function cc --argument container
    cd "$DOTS_COPT_DIR/$container"
end

complete -x --command cc --arguments ( \
    find /opt/containers \
        -maxdepth 1 \
        -mindepth 1 \
        -type d \
        -regextype egrep \
        ! -regex '^\./(\.|_).*' \
        -printf '%P '
)

source (type -P set-env-tmux-parent)
