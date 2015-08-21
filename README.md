# Installation 
on a *nix machine with git and bash, run the following commands to install my dotfiles:

    $ cd ~
    $ git init
    $ git remote add origin https://github.com/sentriz/dotfiles.git
    $ git fetch
    $ mv [your current dotfiles to be replaced] [a safe place]
    $ git checkout -t origin/master
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall
