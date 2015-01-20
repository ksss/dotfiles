#! /bin/sh

if [ ! -d ~/dotfiles/ ]; then
	mkdir ~/dotfiles/
	git clone https://github.com/ksss/dotfiles.git ~/dotfiles/
fi

if [ ! -d ~/.vim-backup/ ]; then
	mkdir ~/.vim-backup/
fi

function links () {
	ln -ivs $1 $2
}

links ~/dotfiles/.vimrc ~/.vimrc
links ~/dotfiles/.screenrc ~/.screenrc
links ~/dotfiles/.bashrc ~/.bashrc
links ~/dotfiles/.zshenv ~/.zshenv
links ~/dotfiles/.zshrc ~/.zshrc
links ~/dotfiles/.tigrc ~/.tigrc
links ~/dotfiles/.gitconfig ~/.gitconfig
links ~/dotfiles/.gitignore ~/.gitignore
links ~/dotfiles/.gemrc ~/.gemrc
links ~/dotfiles/.vim ~/.vim
links ~/dotfiles/bin ~/bin
