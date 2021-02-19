**basic stuff**
```shell
$ install git stow
$ git clone --recurse-submodules https://github.com/sentriz/dotfiles.git ~/dotfiles
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
$ # plugins are loaded from git submodules automatically
```

**neovim stuff**
```shell
$ python3.x -m pip install --user pynvim
$ vim
$ # plugins are loaded from git submodules automatically
```

**python stuff**
```shell
$ # if no pip for pythonx.x
$ curl https://bootstrap.pypa.io/get-pip.py | pythonx.x - --user
```

**extra stuff**
  - desktop extras [docs/desktop/](https://github.com/sentriz/dotfiles/tree/master/docs/desktop)  
  - server extras [docs/server/](https://github.com/sentriz/dotfiles/tree/master/docs/server)  
