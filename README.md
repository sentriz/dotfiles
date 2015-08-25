# Installation 
    $ cd ~
    $ git init
    $ git remote add origin https://github.com/sentriz/dotfiles.git
    $ git fetch
    $ mv [your current dotfiles] [a safe place]
    $ git checkout -t origin/master
    $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    $ vim +PluginInstall +qall
