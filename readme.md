**basic stuff**
```shell
remote $ install git stow
remote $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
remote $ ~/dotfiles/install_common
remote $ # if on an gui system
remote $ ~/dotfiles/install_extra
remote $ # if on the server
remote $ ~/dotfiles/install_server
```

**meta stuff**
```shell
remote $ # setup git hooks
remote $ find hooks/ -type f -exec ln -sf '../../{}' .git/hooks/ \;
```

**fish stuff**
```shell
remote $ rm ~/.bash* ~/.profile ~/whateverelse
remote $ chsh -s $(which fish)
remote $ wget https://git.io/fundle -O ~/.config/fish/functions/fundle.fish
remote $ fundle install
```

**neovim stuff**
```shell
remote $ python3.x -m pip install --user pynvim
remote $ git clone https://github.com/Shougo/dein.vim \
             ~/.cache/dein/repos/github.com/Shougo/dein.vim
remote $ vim '+call dein#install()' '+qall'
```

**python stuff**
```shell
remote $ # if no pip for pythonx.x
remote $ curl https://bootstrap.pypa.io/get-pip.py | pythonx.x - --user
```

**extra stuff**
  - desktop extras [docs/desktop/](https://github.com/sentriz/dotfiles/tree/master/docs/desktop)  
  - server extras [docs/server/](https://github.com/sentriz/dotfiles/tree/master/docs/server)  
