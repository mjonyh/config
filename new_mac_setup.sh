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
brew install tmux

echo "Installing Python with other packages..."
pip3 install numpy scipy matplotlib django pymysql cryptography

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
cd ~

echo "brew cleanup"
brew cleanup
brew update
brew upgrade
brew cleanup

## Some settings for mac
##"Setting screenshot format to PNG"
#defaults write com.apple.screencapture type -string "png"

## for Safari
##"Hiding Safari's bookmarks bar by default"
#defaults write com.apple.Safari ShowFavoritesBar -bool false

##"Hiding Safari's sidebar in Top Sites"
#defaults write com.apple.Safari ShowSidebarInTopSites -bool false

##"Disabling Safari's thumbnail cache for History and Top Sites"
#defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

##"Enabling Safari's debug menu"
#defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

##"Making Safari's search banners default to Contains instead of Starts With"
#defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

##"Removing useless icons from Safari's bookmarks bar"
#defaults write com.apple.Safari ProxiesInBookmarksBar "()"

##"Allow hitting the Backspace key to go to the previous page in history"
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

##"Enabling the Develop menu and the Web Inspector in Safari"
#defaults write com.apple.Safari IncludeDevelopMenu -bool true
#defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
#defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

#killall Finder

# disable last login message in terminal
touch .hushlogin

echo "Changing Shell..."
sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh


echo "Installing Bangla Keyboard Layout Probhat"
curl https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/install.sh | sudo bash
echo "To Configure Go to https://github.com/mdminhazulhaque/probhat-osx"
read -p "Press [Enter] key after this..."
echo "Done!"

