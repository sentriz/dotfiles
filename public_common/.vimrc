" setup plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
source ~/.vim/plugin_list.vim
call vundle#end()
filetype plugin indent on

" setup everything else
source ~/.vim/appearance.vim
source ~/.vim/auto_commands.vim
source ~/.vim/functions.vim
source ~/.vim/improvements.vim
source ~/.vim/mappings.vim
source ~/.vim/plugin_settings.vim
