function fix_ssh
    for expression in (tmux show-env | sed -n 's/^\(SSH_[^=]*\)=\(.*\)/set -x \1 "\2"/p')
        eval "$expression"
    end
end
