# installation 
hmm, i wouldn't actually install my dotfiles, these are like personal notes

basic stuff

    remote $ install git stow fish vim
    remote $ git clone https://github.com/sentriz/dotfiles.git ~/dotfiles
    remote $ chkstow -t ~ # ensure home is clean
    remote $ ~/dotfiles/install_common
    remote $ ~/dotfiles/install_extra # if on an x11 system
    

python stuff

    remote $ curl https://bootstrap.pypa.io/get-pip.py | python - --user

neovim stuff

    remote $ python3.x -m pip install --user pynvim
    remote $ git clone https://github.com/Shougo/dein.vim \
                 ~/.cache/dein/repos/github.com/Shougo/dein.vim
    remote $ vim '+call dein#install()' '+qall'
    
fish setup

    remote $ rm ~/.bash* ~/.profile ~/whateverelse
    remote $ chsh -s $(which fish)

fish extras
    
    remote $ wget https://git.io/fundle -O ~/.config/fish/functions/fundle.fish
    remote $ fundle install
    remote $ python3 -m pip install --user virtualfish

term stuff

    remote $ mkdir -p ~/.terminfo/r/
    local  $ scp /usr/share/terminfo/r/rxvt-unicode-256color \
                 remote:/home/user/.terminfo/r/rxvt-unicode-256color
