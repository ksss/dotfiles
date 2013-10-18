#! /bin/sh

if [ ! -d ~/dotfiles/ ]; then
	mkdir ~/dotfiles/
	git clone git@github.com:ksss/dotfiles.git ~/dotfiles/
fi

function links () {
	ln -ivs $1 $2
}

links ~/dotfiles/.vimrc ~/.vimrc
links ~/dotfiles/.screenrc ~/.screenrc
links ~/dotfiles/.bashrc ~/.bashrc
links ~/dotfiles/.zshrc ~/.zshrc
links ~/dotfiles/.gitconfig ~/.gitconfig
links ~/dotfiles/.gitignore ~/.gitignore
links ~/dotfiles/.vim ~/.vim
links ~/dotfiles/bin ~/bin
