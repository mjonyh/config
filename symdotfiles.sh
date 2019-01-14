#!/bin/sh

# Check if bundle directory exists.
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle

# Check if Vundle installed
[ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mv ~/.zshrc ~/.zshrc.bak
ln -s ~/.dotfiles/zshrc ~/.zshrc
mv ~/.vimrc ~/.vimrc.bak
ln -s ~/.dotfiles/vimrc ~/.vimrc
vim +PluginInstall +qall

cd ~/.vim/bundle/youcompleteme
./install.sh

cd ~
