#!/bin/bash

dir=~/dotfiles
old_dir=~/dotfiles_old
dotfiles="bashrc vimrc vim screenrc gitconfig"

mkdir -p $old_dir

for file in $dotfiles; do
    echo "moving ~/.$file to $old_dir"
    mv ~/.$file $old_dir
    echo "creating symlink ~/.$file => $dir/$file"
    ln -s $dir/$file ~/.$file
done
