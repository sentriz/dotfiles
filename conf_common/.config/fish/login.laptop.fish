switch (tty)
    case /dev/tty1
        exec sway -d >"$XDG_CACHE_HOME/sway_log" 2>&1
    case /dev/tty2
        exec htop
end
