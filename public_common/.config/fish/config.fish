# path stuff
set -x PATH /usr/local/sbin                  $PATH
set -x PATH /usr/local/bin                   $PATH
set -x PATH /usr/sbin /sbin                  $PATH
set -x PATH /bin /usr/bin                    $PATH
set -x PATH $HOME/.local/bin                 $PATH
set -x PATH $HOME/.local/lib/python3.6/site-packages/ $PATH

# recurisve ~/bin in path
if test -d $HOME/bin
    set -x PATH (find -L $HOME/bin -type d) $PATH
end

# sourcy stuff
source $HOME/.keychain/(hostname)-fish > /dev/null 2>&1
source $HOME/.keychain/(hostname)-fish-gpg > /dev/null 2>&1
eval (python3 -m virtualfish auto_activation)

# host specific
if test -f $HOME/.config/fish/(hostname).fish
    source $HOME/.config/fish/(hostname).fish
end
