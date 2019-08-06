# installation
hmm, i wouldn't actually install my dotfiles. these are personal notes

**basic stuff**
```shell
remote $ install git stow
remote $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
remote $ ~/dotfiles/install_common
remote $
remote $ # if on an gui system:
remote $ ~/dotfiles/install_extra 
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
remote $ # if no pip for pythonx.x:
remote $ curl https://bootstrap.pypa.io/get-pip.py | pythonx.x - --user
```

**optional stuff**  
see [system/desktop/](https://github.com/sentriz/dotfiles/tree/wayland/system/desktop)
