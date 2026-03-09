set -xg fish_colour_host blue

function p --argument project
    cd "$PROJECTS_DIR/$project"
end

complete -x --command p --arguments ( \
    find "$PROJECTS_DIR" \
        -maxdepth 1 -mindepth 1 \
        -type d \
        -printf '%P ' \
)
