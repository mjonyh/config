#!/bin/sh

# Check if bundle directory exists.
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle

# Check if Vundle installed
[ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mv ~/.zshrc ~/.zshrc.bak
ln -s new_zshrc ~/.zshrc
mv ~/.vimrc ~/.vimrc.bak
ln -s vimrc_vundle ~/.vimrc
vim +PluginInstall +qall
