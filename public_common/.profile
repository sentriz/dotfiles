#umask 022

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

# # load keys
keychain --systemd --quiet --nogui --agents ssh,gpg id_home 609FCE8BB45971C8293040AC9A8DAE1CA907B862
. ~/.keychain/$HOSTNAME-sh &> /dev/null
. ~/.keychain/$HOSTNAME-sh-gpg &> /dev/null

rm ~/mega/senan_kelly.kdbx.lock &> /dev/null

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && 
exec startx -- -keeptty -nolisten tcp 1> ~/.xorg.log 2>&1
