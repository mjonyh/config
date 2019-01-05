#!/bin/bash

# pathogen installation
file="$HOME/.vim/autoload/pathogen.vim"

if [ -f "$file" ]
then
	echo "Pathogen is installed."
else
	echo "Installing pathogen..."
	mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle && \
	curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

 # NERD tree installation
 file="$HOME/.vim/bundle/nerdtree"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing NERD tree..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/scrooloose/nerdtree
 fi
 
 # vim airline installation
 file="$HOME/.vim/bundle/vim-airline"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing vim-airline..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/bling/vim-airline
 fi
 
 
 # molokai installation
 file="$HOME/.vim/bundle/molokai"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing molokai..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/fatih/molokai
 fi
 
 # dracula theme installation
 file="$HOME/.vim/bundle/vim"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing dracula theme..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/dracula/vim
 fi
 
 # ultisnips installation
 file="$HOME/.vim/bundle/ultisnips"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing ultisnips..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/sirver/ultisnips
 	git clone https://github.com/honza/vim-snippets
 fi
 
 # vim-latex-suite installation
 file="$HOME/.vim/bundle/vim-latex-suite"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing vim-latex-suite..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/gerw/vim-latex-suite
 fi
 
 # vim-live-latex-preview installation
 file="$HOME/.vim/bundle/vim-latex-live-preview"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing vim-live-latex-preview..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/xuhdev/vim-latex-live-preview
 fi
 
 
 #  youcompleteme installation
 file="$HOME/.vim/bundle/youcompleteme"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing youcompleteme..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/valloric/youcompleteme
 	cd youcompleteme
 	git submodule update --init --recursive
 	./install.py
 fi
 
 # git helper installation
 file="$HOME/.vim/bundle/vim-gitgutter"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing vim-gitgutter..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/airblade/vim-gitgutter
 
 	echo "Installing vim-dugitive..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/tpope/vim-dugitive
 fi
 
 # auto-pairs installation
 file="$HOME/.vim/bundle/auto-pairs"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing auto-pairs..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/jiangmiao/auto-pairs
 fi
 
 
 # ctrlp installation
 file="$HOME/.vim/bundle/ctrlp.vim"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing ctrlp..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/kien/ctrlp.vim
 fi
 # commentry airline installation
 file="$HOME/.vim/bundle/vim-commentary"
 if [ -d "$file" ]
 then
 	echo "$file found."
 else
 	echo "Installing commentry..."
 	cd $HOME/.vim/bundle
 	git clone https://github.com/tpope/vim-commentary
 fi
 # commentry airline installation
 file="$HOME/.vim/bundle/vim-easymotion"
 if [ -d "$file" ]
 then
 	echo "$file found."
else
	echo "Installing easymotion..."

	cd $HOME/.vim/bundle
	git clone https://github.com/easymotion/vim-easymotion

fi

# commentry airline installation
file="$HOME/.vim/bundle/vim-autoformat"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "Installing autoformat..."

	cd $HOME/.vim/bundle
	git clone https://github.com/chiel92/vim-autoformat
fi

# vim-fugitive installation
file="$HOME/.vim/bundle/vim-fugitive"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "Installing vim-fugitive..."

	cd $HOME/.vim/bundle
	git clone https://github.com/tpope/vim-fugitive
fi

# Titlecase installation
file="$HOME/.vim/bundle/vim-titlecase"
if [ -d "$file" ]
then
	echo "$file found."
else
	echo "Installing Titlecase..."

	cd $HOME/.vim/bundle
	git clone https://github.com/christoomey/vim-titlecase
fi

# # vimproc installation
 file="$HOME/.vim/bundle/django-plus.vim"
if [ -f "$file" ]
then
	echo "$file found."
else
	echo "Installing django-plus..."

	cd $HOME/.vim/bundle
	git clone https://github.com/tweekmonster/django-plus.vim
fi




