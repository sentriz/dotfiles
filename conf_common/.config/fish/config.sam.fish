set -xg fish_colour_host blue

function p --argument project
    cd "$PROJECTS_DIR/$project"
end
