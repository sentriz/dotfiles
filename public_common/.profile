# source .bashrc if bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc" &> /dev/null
    fi
fi

# recursive $PATH
if [ -d "$HOME/bin" ]; then
    for f in $(find -L $HOME/bin -type d); do
        PATH="$PATH:$f"
    done
fi

# start agents
if [ "$HOSTNAME" == "manjaro" ]; then
    keychain --quiet --nogui --agents ssh,gpg id_home 609FCE8BB45971C8293040AC9A8DAE1CA907B862 &> /dev/null
else
    keychain --quiet --nogui --agents ssh id_raspberry &> /dev/null
fi

# start x
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && 
exec startx -- -keeptty -nolisten tcp 1> ~/.xorg.log 2>&1
