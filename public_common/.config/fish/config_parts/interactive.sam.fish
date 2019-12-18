set -xg fish_color_host blue

# jump to my containers easily with completion
set -g container_dir "/opt/containers"
function cc --argument container
    cd "$container_dir/$container"
end

# need to wrap the inner subshell, so using this extra echo subshell
complete \
    --command cc \
    --arguments (echo (cd "$container_dir"; find \
         . \
         -maxdepth 1 \
         -mindepth 1 \
         -type d \
         -regextype egrep \
         ! -regex '^\./(\.|_).*' \
	 -printf '%P\n'
    ))
