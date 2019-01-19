#!/bin/sh
echo "Please go to the below to to obtain NERD fonts \n"
echo "https://nerdfonts.com \n"
echo "And configure the font for terminal"
read -p "Press [Enter] key after this..."

# zshrc 
mv ~/.zshrc ~/.zshrc.bak
ln -s ~/.dotfiles/zshrc ~/.zshrc

# vimrc 
# Check if bundle directory exists.
[ ! -d ~/.vim/bundle ] && mkdir -p ~/.vim/bundle

# Check if Vundle installed
[ ! -d ~/.vim/bundle/Vundle.vim ] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mv ~/.vimrc ~/.vimrc.bak
ln -s ~/.dotfiles/vimrc ~/.vimrc
vim +PluginInstall +qall

cd ~/.vim/bundle/youcompleteme
./install.sh

cd ~

# Tmux conf
[ ! -d ~/.tmux/plugins ] && mkdir -p ~/.tmux/plugins
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mv ~/.tmux.conf ~/.tmux.conf.bak
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
# start a server but don't attach to it
tmux start-server
# create a new session but don't attach to it either
tmux new-session -d
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh
# killing the server is not required, I guess
tmux kill-server

