# installation 
hmm, i wouldn't actually install my dotfiles, there are like personal notes

    $ install git stow fish vim
    $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
    $ chkstow -t ~ # ensure home is clean
    $ mkdir -p ~/.vim/bundle # ensure stow unfolds .vim for second last step
    $ ~/dotfiles/install_common
    $ ~/dotfiles/install_extra # if on an x11 system
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall
    $ chsh -s $(which fish)
