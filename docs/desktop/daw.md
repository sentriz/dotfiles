### about

this provides good renoise, jack, and windows vst support. where
pulseaudio programs will play just fine at the same time thanks to
pipewire

### packages

- renoise
- yabridge-bin
- wine-staging
- winetricks
- pipewire
- pipewire-jack-dropin

### files

`/etc/systemd/system.conf`

    [Manager]
    DefaultLimitMEMLOCK=100000000

### commands

    $ # setup wine and vst deps
    $ winetricks win7 winxp dotnet40 mdx vcrun6sp6 gdiplus
    $ winecfg  # -> libraries -> set gdiplus native
    $          #              -> set d2d1 disabled

    $ # confirm memlock limit
    $ ulimit --lock-size 
    97656

    $ # install vst
    $ wine path/to/exe
    $ yabridgectl sync

### see also

- [audio](./audio.md) (for the rest of pipewire stuff)
- fish config for `$VST_PATH`, `$VST3_PATH`
