function start_tunnels
    while true
        pgrep 'autossh'; or \
	    autossh \
                -M 0 -N \
                -D 1080 \
                -o ExitOnForwardFailure=yes \
                -o ServerAliveInterval=60 \
                sam
        sleep 10
    end
end
