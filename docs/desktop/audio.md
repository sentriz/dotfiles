### about

ensure these packages are installed early on the system because a lot of
packages depend on pulse and will install actual pulseaudio instead

### packages

- bluez
- bluez-tools
- bluez-utils-compat
- gst-plugin-pipewire
- lib32-pipewire
- lib32-pipewire-jack
- libpipewire02
- pipewire
- pipewire-alsa
- pipewire-jack
- pipewire-media-session
- pipewire-pulse
- pipewire-v4l2
- pipewire-zeroconf

### commands

    $ systemctl enable --now bluetooth
