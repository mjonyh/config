### nvim config setup
echo "Copying nvim config"
echo "This configuration require lua package"

mkdir -p ~/.config/nvim
cd ~/.config/nvim
ln -s ~/.dotfiles/nvim/init.vim init.vim
ln -s ~/.dotfiles/nvim/lua lua

