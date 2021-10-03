### about

ensure these packages are installed early on the system because a lot of
packages depend on pulse and will install actual pulseaudio instead

### packages

- bluez
- bluez-tools
- bluez-utils-compat
- pipewire
- pipewire-alsa
- pipewire-jack
- pipewire-pulse
- pipewire-jack-dropin

### commands

    $ systemctl enable --now bluetooth
