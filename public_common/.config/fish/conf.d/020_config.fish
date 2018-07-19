# fundle
fundle plugin 'laughedelic/fish_logo'
fundle plugin 'fisherman/z'
fundle plugin 'fisherman/done'
fundle plugin 'fisherman/humanize_duration'
fundle plugin 'fisherman/getopts'
fundle init

# host specific
if test -f $HOME/.config/fish/machines/(hostname).fish
    source $HOME/.config/fish/machines/(hostname).fish
end
