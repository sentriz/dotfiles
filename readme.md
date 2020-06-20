**basic stuff**
```shell
$ install git stow
$ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
$ ~/dotfiles/install_common
$ # if on an gui system
$ ~/dotfiles/install_extra
$ # if on the server
$ ~/dotfiles/install_server
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
$ git clone https://github.com/Shougo/dein.vim ~/.cache/dein/repos/github.com/Shougo/dein.vim
$ vim '+call dein#install()' '+qall'
```

**python stuff**
```shell
$ # if no pip for pythonx.x
$ curl https://bootstrap.pypa.io/get-pip.py | pythonx.x - --user
```

**extra stuff**
  - desktop extras [docs/desktop/](https://github.com/sentriz/dotfiles/tree/master/docs/desktop)  
  - server extras [docs/server/](https://github.com/sentriz/dotfiles/tree/master/docs/server)  
