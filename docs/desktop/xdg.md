### about

noticed on one of my installations `xdg-user-dirs` wasn't there, and so these `~/Desktop`, and `~/Downloads` folders kept popping up.
see `public_extra/.config/user-dirs.dirs` for the custom settings

### packages

- xdg-user-dirs

### commands

    $ systemctl --user enable --now xdg-user-dirs-update
