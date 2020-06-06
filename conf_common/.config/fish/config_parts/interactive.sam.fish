set -xg fish_color_host 'blue'

source (type -P set-env-tmux-parent)

# jump to my containers easily with completion
function cc --argument container
    cd "$DOTS_COPT_DIR/$container"
end

complete \
    -x \
    --command cc \
    --arguments (find \
         /opt/containers \
         -maxdepth 1 \
         -mindepth 1 \
         -type d \
         -regextype egrep \
         ! -regex '^\./(\.|_).*' \
         -printf '%P '
    )
