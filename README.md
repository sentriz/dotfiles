# installation 
hmm, i wouldn't actually install my dotfiles, these are like personal notes

basic stuff

    remote $ install git stow fish vim
    remote $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
    remote $ chkstow -t ~ # ensure home is clean
    remote $ mkdir -p ~/.vim/bundle # ensure stow unfolds .vim for second last step
    remote $ ~/dotfiles/install_common
    remote $ ~/dotfiles/install_extra # if on an x11 system
    remote $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    remote $ vim +PluginInstall +qall
    
python stuff

    remote $ wget https://bootstrap.pypa.io/get-pip.py
    remote $ python3 get-pip.py --user
    
fish stuff

    remote $ python3 -m pip install --user virtualfish
    remote $ chsh -s $(which fish)
    
term stuff

    remote $ mkdir -p ~/.terminfo/r/
    local  $ scp /usr/share/terminfo/r/rxvt-unicode-256color \
                 shmig:/home/user/.terminfo/r/rxvt-unicode-256color
