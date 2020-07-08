FROM archlinux

RUN \
    pacman --noconfirm -Syu && \
    pacman --noconfirm -S \
        yarn \
	python \
	python-pip \
        git \
        neovim && \
    pip install --user pynvim && \
    git clone https://github.com/Shougo/dein.vim /root/.cache/dein/repos/github.com/Shougo/dein.vim

COPY . /root/.config/nvim/
RUN \
    nvim '+call dein#install()' '+qall' && \
    nvim '+call coc#util#install()' '+qall'

WORKDIR /project
CMD ["nvim", "."]
