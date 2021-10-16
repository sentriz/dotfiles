set -gx fish_colour_host brgreen

theme dark

function p --argument project
    cd "$DOTS_PROJECTS_DIR/$project"
end

complete -x --command p --arguments ( \
    find "$DOTS_PROJECTS_DIR" \
        -maxdepth 1 -mindepth 1 \
        -type d \
        -printf '%P ' \
)

source (type -P set-env-gpg)
source (type -P set-env-tmux-parent)
