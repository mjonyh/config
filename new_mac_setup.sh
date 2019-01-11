echo "Creating an SSH key for you..."
ssh-keygen -t rsa

echo "Please add this public key to Github \n"
echo "https://github.com/account/ssh \n"
read -p "Press [Enter] key after this..."

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git



echo "Git config"

git config --global user.name "mjonyh"
git config --global user.email mjonyh@gmail.com


echo "Installing brew git utilities..."
brew install git-extras
brew install legit
brew install git-flow

echo "Installing other brew stuff..."
brew install tree
brew install wget
brew install trash
brew install svn
brew install mackup
brew install node
brew install vim --without-python --with-python3
brew install zsh

echo "Cask installation"
brew cask install iterm2
brew cask install spectacle
brew cask install cmake
brew cask install mactex

echo "Copying dotfiles from Github"
cd ~
git clone https://github.com/mjonyh/config.git .dotfiles
cd .dotfiles
sh symdotfiles.sh

echo "Please go to the below to to obtain NERD fonts \n"
echo "https://nerdfonts.com \n"
read -p "Press [Enter] key after this..."




echo "Changing Shell..."
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh



