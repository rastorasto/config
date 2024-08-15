#ohmyzsh theme name kafeitu
#ln -s $PWD/.zprofile ~/.zprofile
#ln -s $PWD/.zshrc ~/.zshrc
mkdir ~/.config
mkdir ~/.config/yabai
mkdir ~/.config/skhd
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.hushlogin ~/.hushlogin
ln -s $PWD/skhdrc ~/.config/skhd/skhdrc
ln -s $PWD/openiterm2.sh ~/.config/skhd/openiterm2.sh
ln -s $PWD/yabairc ~/.config/yabai/yabairc
echo "alias ls='ls -Ga'" >> ~/.zshrc
