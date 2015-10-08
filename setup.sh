#! /bin/sh

if [ ! -d ~/dotfiles/ ]; then
	mkdir ~/dotfiles/
	git clone https://github.com/ksss/dotfiles.git ~/dotfiles/
fi

if [ ! -d ~/.vim-backup/ ]; then
	mkdir ~/.vim-backup/
fi

ln -ivs ~/dotfiles/.vimrc ~/.vimrc
ln -ivs ~/dotfiles/.screenrc ~/.screenrc
ln -ivs ~/dotfiles/.bashrc ~/.bashrc
ln -ivs ~/dotfiles/.zshenv ~/.zshenv
ln -ivs ~/dotfiles/.zshrc ~/.zshrc
ln -ivs ~/dotfiles/.tigrc ~/.tigrc
ln -ivs ~/dotfiles/.gitconfig ~/.gitconfig
ln -ivs ~/dotfiles/.gitignore ~/.gitignore
ln -ivs ~/dotfiles/.gemrc ~/.gemrc
ln -ivs ~/dotfiles/.vim ~/.vim
ln -ivs ~/dotfiles/bin ~/bin
