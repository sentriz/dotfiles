**basic stuff**
```shell
$ install git stow
$ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ ./install-common  # always
$ ./install-extra   # if gui system
$ ./install-server  # if server
```

**meta stuff**
```shell
$ # setup git hooks
$ find hooks/ -type f -exec ln -sf '../../{}' .git/hooks/ \;
```

**fish stuff**
```shell
$ rm ~/.bash* ~/.profile ~/whateverelse
$ chsh -s $(which fish)
$ wget https://git.io/fundle -O ~/.config/fish/functions/fundle.fish
$ fundle install
```

**neovim stuff**
```shell
$ python3.x -m pip install --user pynvim
$ git submodule update --init # get vim plugins
```

**python stuff**
```shell
$ # if no pip for pythonx.x
$ curl https://bootstrap.pypa.io/get-pip.py | pythonx.x - --user
```

**extra stuff**
  - desktop extras [docs/desktop/](https://github.com/sentriz/dotfiles/tree/master/docs/desktop)  
  - server extras [docs/server/](https://github.com/sentriz/dotfiles/tree/master/docs/server)  
