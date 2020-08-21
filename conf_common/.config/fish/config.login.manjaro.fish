switch (tty)
    case '/dev/tty1'
        exec start-sway
    case '/dev/tty2'
        exec htop
end
