# path stuff
set -x PATH /usr/local/sbin  $PATH 2> /dev/null
set -x PATH /usr/local/bin   $PATH 2> /dev/null
set -x PATH /usr/sbin /sbin  $PATH 2> /dev/null
set -x PATH /bin /usr/bin    $PATH 2> /dev/null
set -x PATH $HOME/.local/bin $PATH 2> /dev/null

# recurisve ~/bin in path
if test -d $HOME/bin
    set -x PATH (find -L $HOME/bin -type d) $PATH
end

# host specific
if test -f $HOME/.config/fish/machines/(hostname).fish
    source $HOME/.config/fish/machines/(hostname).fish
end
