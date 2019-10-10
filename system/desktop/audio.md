### packages

- pulseaudio
- pulseaudio-alsa
- pulseaudio-bluetooth (if bluetooth)
- alsa-utils (if dotfiles)

### files

`/etc/pulse/system.pa`

    load-module module-bluetooth-policy
    load-module module-bluetooth-discover
    load-module module-switch-on-connect

### commands

    $ systemctl enable --now bluetooth.service
