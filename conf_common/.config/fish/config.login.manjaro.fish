switch (tty)
    case '/dev/tty1'
        exec env -u DISPLAY -u WAYLAND_DISPLAY sway >~/.cache/sway_log 2>&1
    case '/dev/tty2'
        exec htop
end
