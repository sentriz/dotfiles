# installation 
hmm, i wouldn't actually install my dotfiles, these are like personal notes

basic stuff
    $ install git stow fish vim
    $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
    $ chkstow -t ~ # ensure home is clean
    $ mkdir -p ~/.vim/bundle # ensure stow unfolds .vim for second last step
    $ ~/dotfiles/install_common
    $ ~/dotfiles/install_extra # if on an x11 system
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall
python stuff
    $ wget https://bootstrap.pypa.io/get-pip.py
    $ python3 get-pip.py --user
fish stuff
    $ python3 -m pip install --user virtualfish
    $ chsh -s $(which fish)
term stuff
    $ mkdir -p ~/.terminfo/r/
    $ scp /usr/share/terminfo/r/rxvt-unicode-256color \
          shmig:/home/user/.terminfo/r/rxvt-unicode-256color # local machine
