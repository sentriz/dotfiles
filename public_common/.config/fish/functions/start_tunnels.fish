function start_tunnels
    while true
        sleep 10
        if pgrep 'autossh' 2>&1 > /dev/null
            continue
        end
        autossh \
            -M 0 -N \
            -D 1080 \
            -o ExitOnForwardFailure=yes \
            -o ServerAliveInterval=60 \
            sam
    end
end
