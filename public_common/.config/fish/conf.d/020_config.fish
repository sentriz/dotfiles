# fundle
fundle plugin 'jethrokuan/z' --url 'git@github.com:jethrokuan/z.git#pre27'
fundle plugin 'fisherman/done'
fundle plugin 'fisherman/humanize_duration'
fundle plugin 'fisherman/getopts'
fundle plugin 'fisherman/fzf'
fundle init

# host specific
if test -f $HOME/.config/fish/machines/(hostname).fish
    source $HOME/.config/fish/machines/(hostname).fish
end
