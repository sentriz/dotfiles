# path
set -gx fish_user_paths /usr/local/sbin \
                        /usr/local/bin \
                        /usr/sbin /sbin \
                        /bin /usr/bin \
                        $HOME/.local/bin \
                        $fish_user_paths

# recurisve ~/bin path
if test -d $HOME/bin
    set -gx fish_user_paths (find -L $HOME/bin -type d) \
                            $fish_user_paths
end

# fundle
fundle plugin 'laughedelic/fish_logo'
fundle plugin 'laughedelic/pisces'
fundle plugin 'fisherman/z'
fundle plugin 'fisherman/done'
fundle plugin 'fisherman/humanize_duration'
fundle init

# host specific
if test -f $HOME/.config/fish/machines/(hostname).fish
    source $HOME/.config/fish/machines/(hostname).fish
end
