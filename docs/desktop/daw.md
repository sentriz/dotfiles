### about

this provides good renoise, jack, and windows vst support. where
pulseaudio programs will play just fine at the same time thanks to
pipewire  
wine is wrapped in a sandbox with `bwrap`

### packages

- renoise
- yabridge-bin
- wine-tkg-staging-fsync-git (compile with \_fsync_futex_waitv)
- winetricks
- pipewire
- pipewire-jack-dropin
- realtime-privileges
- bubblewrap
- linux 5.16+ (for futex_waitv)

### commands

    $ # setup wine and vst deps
    $ # extra options WINEARCH, DDLOVERRIDES, etc are in fish config
    $ winetricks -q mfc42 gdiplus

    $ # allow unlimited mem lock size
    $ usermod -a -G video "$USER"
    $ usermod -a -G realtime "$USER"
    $ # relog, and confirm
    $ ulimit --lock-size
    unlimited

    $ # tell yabridge where to find windows vsts
    $ yabridgectl add "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files/VST/"
    $ yabridgectl add "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files (x86)/VST/"
    $ yabridgectl add "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files/Common Files/VST3/"
    $ yabridgectl add "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files (x86)/Common Files/VST3/"

    $ # make sure the daw can find converted
    $ ln -s "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files/VST ~/.vst/yabridge-64
    $ ln -s "$XDG_DATA_HOME/yabridge-wine/drive_c/Program Files (x86)/VST ~/.vst/yabridge-32

    $ # install a new vst
    $ wine path/to/exe # install to path mentioned above
    $ yabridgectl sync

### see also

- [audio](./audio.md) (for the rest of pipewire stuff)
- `yabridge-wine` script, `$VST_PATH`, `$VST3_PATH`
