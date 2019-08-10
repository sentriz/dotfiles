# host specific
if test -f $HOME/.config/fish/machines/(hostname).fish
    source $HOME/.config/fish/machines/(hostname).fish
end

if not status --is-interactive
    exit
end

# fundle
fundle plugin 'jethrokuan/z' --url 'git@github.com:jethrokuan/z.git#pre27'
fundle plugin 'fisherman/done'
fundle plugin 'fishpkg/fish-humanize-duration'
fundle plugin 'fisherman/getopts'
fundle plugin 'fisherman/fzf'
fundle init
