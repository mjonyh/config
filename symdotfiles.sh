#!/bin/sh

sh vim_setup.sh
mv ~/.zshrc ~/.zshrc.bak
ln -s new_zshrc ~/.zshrc
mv ~/.vimrc ~/.vimrc.bak
ln -s vimrc ~/.vimrc
