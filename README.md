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
    
fish setup

    remote $ rm ~/bash* ~/.profile ~/whateverelse
    remote $ chsh -s $(which fish)

fish extras
    
    remote $ wget https://git.io/fundle -O ~/.config/fish/functions/fundle.fish
    remote $ fundle install
    remote $ python3 -m pip install --user virtualfish

term stuff

    remote $ mkdir -p ~/.terminfo/r/
    local  $ scp /usr/share/terminfo/r/rxvt-unicode-256color \
                 shmig:/home/user/.terminfo/r/rxvt-unicode-256color
