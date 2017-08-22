# path stuff
set -x PATH /usr/local/sbin                  $PATH
set -x PATH /usr/local/bin                   $PATH
set -x PATH /usr/sbin /sbin                  $PATH
set -x PATH /bin /usr/bin                    $PATH
set -x PATH $HOME/.local/bin                 $PATH

# recurisve ~/bin in path
if test -d $HOME/bin
    set -x PATH (find -L $HOME/bin -type d) $PATH
end

# host specific
if test -f $HOME/.config/fish/(hostname).fish
    source $HOME/.config/fish/(hostname).fish
end
