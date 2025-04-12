### nvim config setup
echo "Copying nvim config"
echo "This configuration require lua package"

mkdir -p ~/.config/nvim
cd ~/.config/nvim
ln -s ~/git/config/nvim/init.lua init.lua
ln -s ~/git/config/nvim/lua lua

