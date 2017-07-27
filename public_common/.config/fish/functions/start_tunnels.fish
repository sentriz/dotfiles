function start_tunnels
    if pgrep -f '^autossh.*_tunnels$'
        pkill -f --signal SIGUSR1 '^autossh.*_tunnels$'
    else
        autossh -M 0 -f -T -N shmig_tunnels &
        autossh -M 0 -f -T -N osmc_tunnels &
    end
end
