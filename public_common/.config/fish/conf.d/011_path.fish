set -l possible_paths /bin \
              /sbin \
              /usr/bin \
              /usr/local/bin \
              /usr/local/sbin \
              /usr/sbin \
              /opt/Etcher \
              $GEM_HOME/bin \
              $GOPATH/bin \
              $HOME/.local/bin \
              $HOME/node_modules/.bin \
              (find -L $HOME/bin -type d)

for path in $possible_paths
    test -d "$path"
    and set -gx fish_user_paths "$path" $fish_user_paths
end
