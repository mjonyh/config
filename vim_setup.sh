#!/bin/bash

# pathogen installation
file="~/.vim/autoload/pathogen.vim"
if [ -f "$file" ]
then
	echo "Pathogen is installed."
else
	echo "Installing pathogen..."
	mkdir -p ~/.vim/autoload ~/.vim/bundle && \
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# NERD tree installation
file="~/.vim/bundle/nerdtree"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing NERD tree..."
	cd ~/.vim/bundle
	git clone https://github.com/scrooloose/nerdtree
fi

# vim airline installation
file="~/.vim/bundle/vim-airline"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-airline..."
	cd ~/.vim/bundle
	git clone https://github.com/bling/vim-airline
fi


# molokai installation
file="~/.vim/bundle/molokai"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing molokai..."
	cd ~/.vim/bundle
	git clone https://github.com/fatih/molokai
fi

# dracula theme installation
file="~/.vim/bundle/vim"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing dracula theme..."
	cd ~/.vim/bundle
	git clone https://github.com/dracula/vim
fi

# ultisnips installation
file="~/.vim/bundle/ultisnips"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing ultisnips..."
	cd ~/.vim/bundle
	git clone https://github.com/sirver/ultisnips
	git clone https://github.com/honza/vim-snippets
fi

# vim-latex-suite installation
file="~/.vim/bundle/vim-latex-suite"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-latex-suite..."
	cd ~/.vim/bundle
	git clone https://github.com/gerw/vim-latex-suite
fi

# vim-live-latex-preview installation
file="~/.vim/bundle/vim-live-latex-preview"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-live-latex-preview..."
	cd ~/.vim/bundle
	git clone https://github.com/xuhdev/vim-latex-live-preview
fi


#  youcompleteme installation
file="~/.vim/bundle/youcompleteme"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing youcompleteme..."
	cd ~/.vim/bundle
	git clone https://github.com/valloric/youcompleteme
	cd youcompleteme
	git submodule update --init --recursive
	./install.py
fi

# git helper installation
file="~/.vim/bundle/vim-gitgutter"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-gitgutter..."
	cd ~/.vim/bundle
	git clone https://github.com/airblade/vim-gitgutter

	echo "Installing vim-fugitive..."
	cd ~/.vim/bundle
	git clone https://github.com/tpope/vim-fugitive
fi

# auto-pairs installation
file="~/.vim/bundle/auto-pairs"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing auto-pairs..."
	cd ~/.vim/bundle
	git clone https://github.com/jiangmiao/auto-pairs
fi


# ctrlp installation
file="~/.vim/bundle/ctrlp"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing ctrlp..."
	cd ~/.vim/bundle
	git clone https://github.com/kien/ctrlp.vim
fi
# vim airline installation
file="~/.vim/bundle/vim-airline"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-airline..."
fi
